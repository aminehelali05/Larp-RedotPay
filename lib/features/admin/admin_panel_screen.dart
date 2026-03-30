import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_theme.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/scale_button.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _totalController;
  final Map<String, TextEditingController> _assetControllers = {};
  bool _applied = false;
  late final AnimationController _successCtrl;
  late final Animation<double> _successScale;

  @override
  void initState() {
    super.initState();
    final state = ref.read(appStateProvider);
    _totalController = TextEditingController(
        text: state.totalBalance.toStringAsFixed(2));
    for (final asset in state.assets) {
      _assetControllers[asset.symbol] =
          TextEditingController(text: asset.amount.toStringAsFixed(6));
    }

    _successCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _successScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _successCtrl, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _totalController.dispose();
    for (final ctrl in _assetControllers.values) {
      ctrl.dispose();
    }
    _successCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ───
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Row(
                children: [
                  ScaleButton(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_rounded, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Text('Admin Mode',
                      style: textTheme.titleLarge?.copyWith(fontSize: 20)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.brandRed.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('HIDDEN',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.brandRed,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                children: [
                  // Total balance
                  _buildField(
                    label: 'Total Balance (USD)',
                    controller: _totalController,
                    icon: Icons.account_balance_wallet_rounded,
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('Individual Assets',
                        style: textTheme.titleMedium
                            ?.copyWith(color: AppColors.textMuted)),
                  ),

                  // Asset fields
                  for (final asset in state.assets)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildField(
                        label: '${asset.symbol} amount',
                        controller: _assetControllers[asset.symbol]!,
                        icon: Icons.currency_bitcoin,
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Apply button
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ScaleButton(
                        onTap: _apply,
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.brandRed,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Apply Changes',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      if (_applied)
                        ScaleTransition(
                          scale: _successScale,
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_rounded,
                                color: Colors.white, size: 28),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: AppColors.textMuted, fontSize: 13),
        prefixIcon:
            Icon(icon, color: AppColors.textMuted, size: 20),
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: AppColors.brandRed, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
      ),
    );
  }

  Future<void> _apply() async {
    final controller = ref.read(appStateProvider.notifier);

    final total = double.tryParse(
        _totalController.text.trim().replaceAll(',', ''));
    if (total != null) {
      await controller.setTotalBalance(total);
    }

    for (final entry in _assetControllers.entries) {
      final parsed = double.tryParse(
          entry.value.text.trim().replaceAll(',', ''));
      if (parsed != null) {
        await controller.setAssetAmount(entry.key, parsed);
      }
    }

    setState(() => _applied = true);
    _successCtrl.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _applied = false);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Balances updated & saved locally ✓'),
      ),
    );
  }
}
