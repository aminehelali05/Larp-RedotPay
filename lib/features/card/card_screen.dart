import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_theme.dart';
import '../../core/models/transaction_item.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/scale_button.dart';

class CardScreen extends ConsumerStatefulWidget {
  const CardScreen({super.key});

  @override
  ConsumerState<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends ConsumerState<CardScreen>
    with SingleTickerProviderStateMixin {
  bool _showBack = false;
  late final AnimationController _flipCtrl;
  late final Animation<double> _flipAnim;

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_showBack) {
      _flipCtrl.reverse();
    } else {
      _flipCtrl.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final txs = ref.watch(appStateProvider.select((s) => s.transactions));

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 100),
        children: [
          // ─── Header ───
          Row(
            children: [
              Text('Cards',
                  style: textTheme.headlineLarge?.copyWith(fontSize: 30)),
              const Spacer(),
              ScaleButton(
                onTap: () => _showSnack('Card mail'),
                child: const Icon(Icons.mark_email_read_outlined,
                    size: 22, color: Colors.white),
              ),
              const SizedBox(width: 16),
              ScaleButton(
                onTap: () => _showSnack('Add new card'),
                child: const Icon(Icons.add_circle_outline,
                    size: 22, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // ─── Card with flip ───
          GestureDetector(
            onTap: _toggleFlip,
            child: AnimatedBuilder(
              animation: _flipAnim,
              builder: (_, __) {
                final angle = _flipAnim.value * pi;
                final isFront = angle < pi / 2;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: isFront
                      ? _buildCardFront(textTheme)
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(pi),
                          child: _buildCardBack(textTheme),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),

          // ─── Action Buttons ───
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CardAction(
                  icon: Icons.visibility_outlined,
                  label: 'View',
                  onTap: _toggleFlip),
              _CardAction(
                  icon: Icons.ac_unit_rounded,
                  label: 'Freeze',
                  onTap: () => _showSnack('Card frozen')),
              _CardAction(
                  icon: Icons.tune_rounded,
                  label: 'Limit',
                  onTap: () => _showSnack('Spending limit')),
              _CardAction(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => _showSnack('Card settings')),
            ],
          ),
          const SizedBox(height: 26),

          // ─── Transactions ───
          Row(
            children: [
              Text('Transactions',
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.filter_list_rounded,
                  color: AppColors.textMuted, size: 20),
              const SizedBox(width: 14),
              const Icon(Icons.more_horiz, color: AppColors.textMuted, size: 20),
            ],
          ),
          const SizedBox(height: 14),

          // Date header
          Text(
            'Wed, Apr 02',
            style: textTheme.bodySmall
                ?.copyWith(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 10),

          for (final tx in txs.take(3))
            _TxTile(tx: tx, textTheme: textTheme),

          const SizedBox(height: 14),
          Text(
            'Tue, Apr 01',
            style: textTheme.bodySmall
                ?.copyWith(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 10),
          for (final tx in txs.skip(3).take(3))
            _TxTile(tx: tx, textTheme: textTheme),

          const SizedBox(height: 14),
          Text(
            'Sun, Mar 30',
            style: textTheme.bodySmall
                ?.copyWith(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 10),
          for (final tx in txs.skip(6))
            _TxTile(tx: tx, textTheme: textTheme),
        ],
      ),
    );
  }

  Widget _buildCardFront(TextTheme textTheme) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1C24), Color(0xFF2E3040)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.brandRed,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('P',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 6),
              Text('RedotPay',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
              const Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow.withAlpha(120),
                      Colors.green.withAlpha(120),
                      Colors.blue.withAlpha(120),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '•• 4126',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Text(
                'VISA',
                style: textTheme.headlineLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(TextTheme textTheme) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2E3040), Color(0xFF1A1C24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 36,
            color: Colors.black54,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.white12,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerRight,
                  child: Text('842',
                      style: textTheme.titleMedium?.copyWith(fontSize: 16)),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text('4532 •••• •••• 4126',
              style: textTheme.bodySmall?.copyWith(
                fontSize: 14,
                letterSpacing: 2,
                color: Colors.white60,
              )),
          const SizedBox(height: 4),
          Text('12/28',
              style: textTheme.bodySmall
                  ?.copyWith(fontSize: 13, color: Colors.white60)),
        ],
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction(
      {required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: AppColors.cardDark,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _TxTile extends StatelessWidget {
  const _TxTile({required this.tx, required this.textTheme});
  final TransactionItem tx;
  final TextTheme textTheme;

  static const Map<String, Color> _iconColors = {
    'N': Color(0xFFE50914), // Netflix
    'A': Color(0xFF555555), // Apple
    'S': Color(0xFF1DB954), // Spotify
    'a': Color(0xFFFF9900), // Amazon
    'U': Color(0xFF06C167), // Uber
    '₮': Color(0xFF26A17B), // Tether
    'G': Color(0xFF4285F4), // Google
  };

  @override
  Widget build(BuildContext context) {
    final color = _iconColors[tx.icon] ?? const Color(0xFF8D8E96);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(40),
            ),
            child: Center(
              child: Text(
                tx.icon,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color,
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
      ),
    );
  }
}
