import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/theme/app_theme.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/scale_button.dart';
import '../profile/profile_settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _balanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ───
            _buildHeader(context, textTheme),
            const SizedBox(height: 26),

            // ─── Balance Section ───
            _buildBalanceSection(appState.totalBalance, textTheme),
            const SizedBox(height: 24),

            // ─── Quick Actions ───
            const _QuickActionsRow(),
            const SizedBox(height: 24),

            // ─── Invite Card ───
            _buildInviteCard(textTheme),
            const SizedBox(height: 16),

            // ─── Credit Card ───
            _buildCreditCard(textTheme),
            const SizedBox(height: 16),

            // ─── Transactions ───
            _TransactionsSection(textTheme: textTheme),
          ],
        ),
      ),
    );
  }

  // ─────────────────── HEADER ───────────────────
  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileSettingsScreen()),
          ),
          child: const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF2A2D36),
            child: Icon(Icons.person, color: Colors.white54, size: 22),
          ),
        ),
        const Spacer(),
        Text(
          'RedotPay',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        _headerIcon(Icons.qr_code_scanner_rounded, 'QR Scanner'),
        const SizedBox(width: 16),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _headerIcon(Icons.notifications_none_rounded, 'Notifications'),
            Positioned(
              right: 0,
              top: -1,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.brandRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        _headerIcon(Icons.headset_mic_outlined, 'Support'),
      ],
    );
  }

  Widget _headerIcon(IconData icon, String tooltip) {
    return ScaleButton(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$tooltip coming soon!')),
      ),
      child: Icon(icon, size: 22, color: Colors.white),
    );
  }

  // ─────────────────── BALANCE ───────────────────
  Widget _buildBalanceSection(double balance, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onTap: () => setState(() => _balanceVisible = !_balanceVisible),
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
                    tween: Tween(begin: 0, end: balance),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                    builder: (_, val, __) {
                      return Text(
                        NumberFormat('#,##0.00').format(val),
                        style: textTheme.headlineLarge?.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      );
                    },
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
                  Text(
                    'USD',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down,
                      size: 22, color: Colors.white70),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────── INVITE CARD ───────────────────
  Widget _buildInviteCard(TextTheme textTheme) {
    return ScaleButton(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referral program coming soon!')),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.surfaceDark,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invite friends',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Earn up to 40% commission!',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFD0D3DC).withAlpha(60),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.monetization_on_rounded,
                  size: 32, color: AppColors.brandRed),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────── CREDIT CARD ───────────────────
  Widget _buildCreditCard(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Credit',
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Limit Up to (USD)',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              '****',
              style: textTheme.headlineLarge
                  ?.copyWith(fontSize: 28, letterSpacing: 6),
            ),
          ),
          const SizedBox(height: 18),
          ScaleButton(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Getting your credit limit...')),
            ),
            child: Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                'Get Your Limit',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────── QUICK ACTIONS ───────────────────
class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _QuickAction(label: 'Deposit', icon: Icons.add, isWhite: true),
        _QuickAction(label: 'Buy Crypto', icon: Icons.bolt_outlined),
        _QuickAction(label: 'Swap', icon: Icons.swap_horiz_rounded),
        _QuickAction(label: 'More', icon: Icons.more_horiz),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.label,
    required this.icon,
    this.isWhite = false,
  });

  final String label;
  final IconData icon;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label feature coming soon!')),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isWhite ? Colors.white : AppColors.cardDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 26,
              color: isWhite ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────── TRANSACTIONS ───────────────────
class _TransactionsSection extends ConsumerWidget {
  const _TransactionsSection({required this.textTheme});
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(appStateProvider.select((s) => s.transactions));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Transactions',
                  style:
                      textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.more_horiz, color: AppColors.textMuted, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < txs.length && i < 3; i++) ...[
            _TransactionTile(tx: txs[i], textTheme: textTheme),
            if (i < 2) const Divider(height: 20, color: AppColors.divider),
          ],
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.tx, required this.textTheme});
  final dynamic tx;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Google "1" icon
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF1A1D26),
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF4285F4), // Blue
                  Color(0xFFDB4437), // Red
                  Color(0xFFF4B400), // Yellow
                  Color(0xFF0F9D58), // Green
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                '1',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tx.merchant,
                  style: textTheme.titleMedium?.copyWith(fontSize: 14)),
              const SizedBox(height: 2),
              Text(tx.maskedCard,
                  style: textTheme.bodySmall?.copyWith(fontSize: 11)),
              Text(tx.timestamp,
                  style: textTheme.bodySmall?.copyWith(fontSize: 11)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${tx.amountUsd >= 0 ? '+' : ''}${tx.amountUsd.toStringAsFixed(2)} USD',
              style: textTheme.titleMedium?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              tx.status,
              style: textTheme.bodySmall?.copyWith(
                color: tx.status == 'Declined'
                    ? AppColors.declined
                    : AppColors.green,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
