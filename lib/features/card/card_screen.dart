import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/app_state_controller.dart';

class CardScreen extends ConsumerWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(appStateProvider.select((s) => s.transactions));

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 130),
        children: [
          Text('Cards', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 52)),
          const SizedBox(height: 18),
          Container(
            height: 205,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(colors: [Color(0xFF121318), Color(0xFF2C2E37)]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RedotPay', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
                const Spacer(),
                Row(
                  children: [
                    const Text('•• 4126', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text('VISA', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 58)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _Action(icon: Icons.visibility_outlined, label: 'View'),
              _Action(icon: Icons.ac_unit, label: 'Freeze'),
              _Action(icon: Icons.tune, label: 'Limit'),
              _Action(icon: Icons.settings, label: 'Settings'),
            ],
          ),
          const SizedBox(height: 26),
          Text('Transactions', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          for (final tx in txs)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF222530),
                child: Text('1', style: TextStyle(color: Color(0xFFFFC400), fontSize: 20)),
              ),
              title: Text(tx.merchant),
              subtitle: Text('${tx.maskedCard}\n${tx.timestamp}'),
              isThreeLine: true,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${tx.amountUsd.toStringAsFixed(2)} USD'),
                  Text(
                    tx.status,
                    style: const TextStyle(color: Color(0xFFFF7690)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: const BoxDecoration(color: Color(0xFF242731), shape: BoxShape.circle),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
