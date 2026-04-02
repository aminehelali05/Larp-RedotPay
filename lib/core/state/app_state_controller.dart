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
    totalBalance: 248750.00,
    assets: [
      AssetBalance(symbol: 'USDT', name: 'TetherUS', amount: 85420.00, usdRate: 1.0, icon: ''),
      AssetBalance(symbol: 'BTC', name: 'Bitcoin', amount: 1.2847, usdRate: 84650.0, icon: ''),
      AssetBalance(symbol: 'ETH', name: 'Ethereum', amount: 14.732, usdRate: 3485.0, icon: ''),
      AssetBalance(symbol: 'SOL', name: 'Solana', amount: 126.50, usdRate: 178.0, icon: ''),
      AssetBalance(symbol: 'BNB', name: 'BNB', amount: 18.45, usdRate: 605.0, icon: ''),
      AssetBalance(symbol: 'USDC', name: 'USDC', amount: 12500.00, usdRate: 1.0, icon: ''),
      AssetBalance(symbol: 'XRP', name: 'XRP', amount: 4500.0, usdRate: 2.18, icon: ''),
      AssetBalance(symbol: 'ADA', name: 'Cardano', amount: 8200.0, usdRate: 0.72, icon: ''),
      AssetBalance(symbol: 'AVAX', name: 'Avalanche', amount: 95.0, usdRate: 42.50, icon: ''),
      AssetBalance(symbol: 'MATIC', name: 'Polygon', amount: 3200.0, usdRate: 0.92, icon: ''),
      AssetBalance(symbol: 'DOT', name: 'Polkadot', amount: 320.0, usdRate: 8.15, icon: ''),
      AssetBalance(symbol: 'DOGE', name: 'Dogecoin', amount: 15000.0, usdRate: 0.168, icon: ''),
    ],
    transactions: [
      TransactionItem(
        merchant: 'Netflix',
        maskedCard: '•• 4126',
        timestamp: '2026-04-02 09:14:22',
        amountUsd: -15.99,
        status: 'Completed',
        icon: 'N',
      ),
      TransactionItem(
        merchant: 'Apple Store',
        maskedCard: '•• 4126',
        timestamp: '2026-04-01 18:33:07',
        amountUsd: -249.00,
        status: 'Completed',
        icon: 'A',
      ),
      TransactionItem(
        merchant: 'Spotify Premium',
        maskedCard: '•• 4126',
        timestamp: '2026-04-01 12:05:44',
        amountUsd: -9.99,
        status: 'Completed',
        icon: 'S',
      ),
      TransactionItem(
        merchant: 'Amazon',
        maskedCard: '•• 4126',
        timestamp: '2026-03-31 22:18:55',
        amountUsd: -87.50,
        status: 'Completed',
        icon: 'a',
      ),
      TransactionItem(
        merchant: 'Uber Eats',
        maskedCard: '•• 4126',
        timestamp: '2026-03-31 20:42:11',
        amountUsd: -32.40,
        status: 'Completed',
        icon: 'U',
      ),
      TransactionItem(
        merchant: 'Crypto Deposit',
        maskedCard: 'USDT TRC20',
        timestamp: '2026-03-30 14:20:33',
        amountUsd: 5000.00,
        status: 'Completed',
        icon: '₮',
      ),
      TransactionItem(
        merchant: 'Google One',
        maskedCard: '•• 4126',
        timestamp: '2026-03-29 03:01:32',
        amountUsd: -19.99,
        status: 'Declined',
        icon: 'G',
      ),
      TransactionItem(
        merchant: 'Steam',
        maskedCard: '•• 4126',
        timestamp: '2026-03-28 15:44:20',
        amountUsd: -59.99,
        status: 'Completed',
        icon: 'S',
      ),
    ],
    themeMode: ThemeMode.dark,
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
