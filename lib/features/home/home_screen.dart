import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/state/app_state_controller.dart';
import '../profile/profile_settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final controller = ref.read(appStateProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileSettingsScreen()),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF2A2D36),
                    child: Icon(Icons.person, color: Colors.white60),
                  ),
                ),
                const Spacer(),
                Text('RedotPay', style: textTheme.titleLarge),
                const Spacer(),
                const Icon(Icons.qr_code_scanner_rounded, size: 23),
                const SizedBox(width: 14),
                Stack(
                  clipBehavior: Clip.none,
                  children: const [
                    Icon(Icons.notifications_none_rounded, size: 24),
                    Positioned(
                      right: 0,
                      top: -1,
                      child: CircleAvatar(radius: 4.5, backgroundColor: Color(0xFFFA2E57)),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Icon(Icons.headset_mic_outlined, size: 23),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Text('Est. total value', style: textTheme.bodySmall),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8D8E96), size: 19),
                const SizedBox(width: 12),
                const Icon(Icons.remove_red_eye_outlined, color: Color(0xFF8D8E96), size: 20),
              ],
            ),
            const SizedBox(height: 9),
            GestureDetector(
              onDoubleTap: () => _editBalanceDialog(context, controller, appState.totalBalance),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat('#,##0.00').format(appState.totalBalance),
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text('USD', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                        const Icon(Icons.arrow_drop_down, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _QuickAction(label: 'Deposit', icon: Icons.add, selected: true),
                _QuickAction(label: 'Buy Crypto', icon: Icons.bolt_outlined),
                _QuickAction(label: 'Swap', icon: Icons.swap_horiz),
                _QuickAction(label: 'More', icon: Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 24),
            _InviteCard(textTheme: textTheme),
            const SizedBox(height: 16),
            _CreditCardMock(textTheme: textTheme),
            const SizedBox(height: 16),
            _TransactionPreview(textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  Future<void> _editBalanceDialog(
    BuildContext context,
    AppStateController controller,
    double current,
  ) async {
    final textCtrl = TextEditingController(text: current.toStringAsFixed(2));

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit total balance'),
          content: TextField(
            controller: textCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(prefixText: '\$ '),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                final parsed = double.tryParse(textCtrl.text.trim().replaceAll(',', ''));
                if (parsed != null) {
                  await controller.setTotalBalance(parsed);
                }
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.label,
    required this.icon,
    this.selected = false,
  });

  final String label;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFF2F2F2) : const Color(0xFF242731),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 34, color: selected ? Colors.black : Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF272730), Color(0xFF343540)]),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Invite friends', style: textTheme.titleMedium?.copyWith(color: const Color(0xFF8D8E96))),
                const SizedBox(height: 8),
                Text('Earn up to 40% commission!', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(color: Color(0xFFC8CBD7), shape: BoxShape.circle),
            child: const Icon(Icons.monetization_on, size: 35, color: Color(0xFFFA2E57)),
          ),
        ],
      ),
    );
  }
}

class _CreditCardMock extends StatelessWidget {
  const _CreditCardMock({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F26),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Credit', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Color(0xFF8D8E96)),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Limit Up to (USD)',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8D8E96),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text('****', style: textTheme.headlineLarge?.copyWith(fontSize: 52)),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text('Get Your Limit', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _TransactionPreview extends ConsumerWidget {
  const _TransactionPreview({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(appStateProvider.select((s) => s.transactions));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F26),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Transactions', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Color(0xFF8D8E96)),
            ],
          ),
          const SizedBox(height: 14),
          for (final tx in txs.take(2))
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF20232D),
                    ),
                    child: const Center(
                      child: Text('1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFFFC400))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tx.merchant, style: textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(tx.maskedCard, style: textTheme.bodySmall),
                        Text(tx.timestamp, style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${tx.amountUsd >= 0 ? '+' : ''}${tx.amountUsd.toStringAsFixed(2)} USD',
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        tx.status,
                        style: textTheme.bodyLarge?.copyWith(
                          color: tx.status == 'Declined' ? const Color(0xFFFF7690) : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
