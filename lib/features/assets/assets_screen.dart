import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/theme/app_theme.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/crypto_icon.dart';
import '../../core/widgets/scale_button.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  bool _balanceVisible = true;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateProvider);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Balance Header ───
            Row(
              children: [
                Text(
                  'Est. total value',
                  style: textTheme.bodySmall?.copyWith(fontSize: 13),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.textMuted, size: 18),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () =>
                      setState(() => _balanceVisible = !_balanceVisible),
                  child: Icon(
                    _balanceVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textMuted,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                _balanceVisible
                    ? TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: state.totalBalance),
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeOutCubic,
                        builder: (_, val, __) => Text(
                          NumberFormat('#,##0.00').format(val),
                          style: textTheme.headlineLarge?.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                      )
                    : Text(
                        '****',
                        style: textTheme.headlineLarge?.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    children: [
                      Text('USD',
                          style: textTheme.titleMedium
                              ?.copyWith(color: Colors.white70)),
                      const Icon(Icons.arrow_drop_down,
                          size: 22, color: Colors.white70),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ─── Top Buttons ───
            Row(
              children: [
                Expanded(
                    child: _TopButton('Add funds',
                        isWhite: true, ctx: context)),
                const SizedBox(width: 10),
                Expanded(
                    child: _TopButton('Earn', ctx: context)),
                const SizedBox(width: 10),
                Expanded(
                    child: _TopButton('Credit', ctx: context)),
              ],
            ),
            const SizedBox(height: 24),

            // ─── Crypto / Fiat Tabs ───
            TabBar(
              controller: _tabCtrl,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textMuted,
              labelStyle: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
              unselectedLabelStyle: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Crypto'),
                Tab(text: 'Fiat'),
              ],
            ),

            // ─── Asset List ───
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  // Crypto tab
                  ListView.separated(
                    padding: const EdgeInsets.only(top: 12, bottom: 100),
                    itemCount: state.assets.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (context, index) {
                      final asset = state.assets[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          children: [
                            CryptoIcon(symbol: asset.symbol, size: 40),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(asset.symbol,
                                      style: textTheme.titleMedium
                                          ?.copyWith(fontSize: 15)),
                                  const SizedBox(height: 2),
                                  Text(asset.name,
                                      style: textTheme.bodySmall
                                          ?.copyWith(fontSize: 12)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _balanceVisible
                                      ? asset.amount.toStringAsFixed(2)
                                      : '****',
                                  style: textTheme.titleMedium
                                      ?.copyWith(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _balanceVisible
                                      ? '≈ ${asset.usdValue.toStringAsFixed(2)} USD'
                                      : '≈ **** USD',
                                  style: textTheme.bodySmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Fiat tab
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.account_balance_outlined,
                              size: 48, color: AppColors.textMuted),
                          const SizedBox(height: 16),
                          Text(
                            'No fiat balances yet',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton(this.label, {this.isWhite = false, required this.ctx});

  final String label;
  final bool isWhite;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('$label coming soon!')),
      ),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: isWhite ? Colors.white : AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isWhite ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
