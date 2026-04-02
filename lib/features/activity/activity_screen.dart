import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/theme/app_theme.dart';
import '../../core/models/transaction_item.dart';
import '../../core/state/app_state_controller.dart';
import '../../core/widgets/scale_button.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(appStateProvider.select((s) => s.transactions));
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
            child: Row(
              children: [
                Text('Activity',
                    style: textTheme.headlineLarge?.copyWith(fontSize: 30)),
                const Spacer(),
                ScaleButton(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter transactions')),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.filter_list_rounded, size: 16, color: Colors.white70),
                        const SizedBox(width: 6),
                        Text('Filter', style: textTheme.bodySmall?.copyWith(
                          fontSize: 13, color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ─── Stats Row ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(child: _StatCard(
                  label: 'Total Spent',
                  value: '-\$${NumberFormat('#,##0.00').format(474.86)}',
                  color: AppColors.declined,
                )),
                const SizedBox(width: 10),
                Expanded(child: _StatCard(
                  label: 'Total Received',
                  value: '+\$${NumberFormat('#,##0.00').format(5000.00)}',
                  color: AppColors.green,
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text('All Transactions',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),

          // ─── Transaction List ───
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 100),
              itemCount: txs.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (context, index) {
                final tx = txs[index];
                return _ActivityTile(tx: tx, textTheme: textTheme);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.tx, required this.textTheme});
  final TransactionItem tx;
  final TextTheme textTheme;

  static const Map<String, Color> _iconColors = {
    'N': Color(0xFFE50914),
    'A': Color(0xFF555555),
    'S': Color(0xFF1DB954),
    'a': Color(0xFFFF9900),
    'U': Color(0xFF06C167),
    '₮': Color(0xFF26A17B),
    'G': Color(0xFF4285F4),
  };

  @override
  Widget build(BuildContext context) {
    final color = _iconColors[tx.icon] ?? const Color(0xFF8D8E96);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(30),
            ),
            child: Center(
              child: Text(tx.icon,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: color)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.merchant,
                    style: textTheme.titleMedium?.copyWith(fontSize: 15)),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(tx.maskedCard,
                        style: textTheme.bodySmall?.copyWith(fontSize: 12)),
                    const SizedBox(width: 8),
                    Text('•', style: textTheme.bodySmall?.copyWith(fontSize: 12)),
                    const SizedBox(width: 8),
                    Text(tx.timestamp.split(' ')[0],
                        style: textTheme.bodySmall?.copyWith(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${tx.amountUsd >= 0 ? '+' : ''}${NumberFormat('#,##0.00').format(tx.amountUsd)} USD',
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: tx.amountUsd >= 0 ? AppColors.green : Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: tx.status == 'Declined'
                      ? AppColors.declined.withAlpha(20)
                      : AppColors.green.withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tx.status,
                  style: textTheme.bodySmall?.copyWith(
                    color: tx.status == 'Declined'
                        ? AppColors.declined
                        : AppColors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
