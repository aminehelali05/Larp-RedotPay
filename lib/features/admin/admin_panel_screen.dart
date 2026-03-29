import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/app_state_controller.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  late final TextEditingController _totalController;
  final Map<String, TextEditingController> _assetControllers = {};

  @override
  void initState() {
    super.initState();
    final state = ref.read(appStateProvider);
    _totalController = TextEditingController(text: state.totalBalance.toStringAsFixed(2));
    for (final asset in state.assets) {
      _assetControllers[asset.symbol] = TextEditingController(text: asset.amount.toStringAsFixed(6));
    }
  }

  @override
  void dispose() {
    _totalController.dispose();
    for (final ctrl in _assetControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Mode')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
        children: [
          Text(
            'Hidden Controls',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _totalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Total balance (USD)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          for (final asset in state.assets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _assetControllers[asset.symbol],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: '${asset.symbol} amount',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _apply,
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Future<void> _apply() async {
    final controller = ref.read(appStateProvider.notifier);

    final total = double.tryParse(_totalController.text.trim().replaceAll(',', ''));
    if (total != null) {
      await controller.setTotalBalance(total);
    }

    for (final entry in _assetControllers.entries) {
      final parsed = double.tryParse(entry.value.text.trim().replaceAll(',', ''));
      if (parsed != null) {
        await controller.setAssetAmount(entry.key, parsed);
      }
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fake balances updated and saved locally.')),
    );
  }
}
