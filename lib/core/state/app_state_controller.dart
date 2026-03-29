import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/asset_balance.dart';
import '../models/transaction_item.dart';
import '../storage/local_storage.dart';
import 'app_state.dart';

final appStateProvider = StateNotifierProvider<AppStateController, DemoAppState>(
  (ref) => AppStateController(LocalStorage()),
);

class AppStateController extends StateNotifier<DemoAppState> {
  AppStateController(this._storage) : super(_initialState) {
    _bootstrap();
  }

  final LocalStorage _storage;

  static const DemoAppState _initialState = DemoAppState(
    totalBalance: 3.39,
    assets: [
      AssetBalance(symbol: 'USDT', name: 'TetherUS', amount: 3.00, usdRate: 1.0, icon: '🟦'),
      AssetBalance(symbol: 'USDⓢ', name: 'USDⓢ', amount: 0.39, usdRate: 1.0, icon: '🟢'),
      AssetBalance(symbol: 'USDC', name: 'USDC', amount: 0.00, usdRate: 1.0, icon: '🔵'),
      AssetBalance(symbol: 'BTC', name: 'Bitcoin', amount: 0.00, usdRate: 69650, icon: '🟠'),
      AssetBalance(symbol: 'ETH', name: 'Ethereum', amount: 0.00, usdRate: 3550, icon: '🟣'),
      AssetBalance(symbol: 'SOL', name: 'Solana', amount: 0.00, usdRate: 170, icon: '🟪'),
      AssetBalance(symbol: 'BNB', name: 'BNB', amount: 0.00, usdRate: 590, icon: '🟡'),
    ],
    transactions: [
      TransactionItem(
        merchant: 'Google One',
        maskedCard: '.. 4126',
        timestamp: '2026-03-29 03:01:32',
        amountUsd: -19.99,
        status: 'Declined',
        icon: '1',
      ),
      TransactionItem(
        merchant: 'GOOGLE *Google One',
        maskedCard: '.. 4126',
        timestamp: '2026-03-29 03:01:29',
        amountUsd: -19.99,
        status: 'Declined',
        icon: '1',
      ),
      TransactionItem(
        merchant: 'GOOGLE *Instagram',
        maskedCard: '.. 4126',
        timestamp: '2026-03-28 12:33:17',
        amountUsd: 0.39,
        status: 'Completed',
        icon: '1',
      ),
    ],
    themeMode: ThemeMode.system,
  );

  Future<void> _bootstrap() async {
    final persisted = await _storage.loadState();
    if (persisted != null) {
      state = persisted;
    }
  }

  Future<void> setTotalBalance(double value) async {
    state = state.copyWith(totalBalance: value);
    await _storage.saveState(state);
  }

  Future<void> setAssetAmount(String symbol, double amount) async {
    final updated = state.assets
        .map((asset) => asset.symbol == symbol ? asset.copyWith(amount: amount) : asset)
        .toList();
    state = state.copyWith(assets: updated);
    await _storage.saveState(state);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _storage.saveState(state);
  }
}
