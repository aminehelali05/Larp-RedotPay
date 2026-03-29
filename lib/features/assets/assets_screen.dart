import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/app_state_controller.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Est. total value', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFF8D8E96))),
            const SizedBox(height: 6),
            Text('${state.totalBalance.toStringAsFixed(2)} USD', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 66)),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: _TopButton('Add funds', selected: true)),
                SizedBox(width: 10),
                Expanded(child: _TopButton('Earn')),
                SizedBox(width: 10),
                Expanded(child: _TopButton('Credit')),
              ],
            ),
            const SizedBox(height: 26),
            Expanded(
              child: ListView.separated(
                itemCount: state.assets.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final asset = state.assets[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1F222B),
                      child: Text(asset.icon, style: const TextStyle(fontSize: 18)),
                    ),
                    title: Text(asset.symbol),
                    subtitle: Text(asset.name),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(asset.amount.toStringAsFixed(2), style: Theme.of(context).textTheme.titleMedium),
                        Text('≈ ${asset.usdValue.toStringAsFixed(2)} USD', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton(this.label, {this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFF242731),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
