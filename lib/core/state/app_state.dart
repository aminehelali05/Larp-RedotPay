import 'package:flutter/material.dart';

import '../models/asset_balance.dart';
import '../models/transaction_item.dart';

class DemoAppState {
  const DemoAppState({
    required this.totalBalance,
    required this.assets,
    required this.transactions,
    required this.themeMode,
  });

  final double totalBalance;
  final List<AssetBalance> assets;
  final List<TransactionItem> transactions;
  final ThemeMode themeMode;

  DemoAppState copyWith({
    double? totalBalance,
    List<AssetBalance>? assets,
    List<TransactionItem>? transactions,
    ThemeMode? themeMode,
  }) {
    return DemoAppState(
      totalBalance: totalBalance ?? this.totalBalance,
      assets: assets ?? this.assets,
      transactions: transactions ?? this.transactions,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'assets': assets.map((e) => e.toJson()).toList(),
      'transactions': transactions.map((e) => e.toJson()).toList(),
      'themeMode': themeMode.name,
    };
  }

  factory DemoAppState.fromJson(Map<String, dynamic> json) {
    return DemoAppState(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      assets: (json['assets'] as List<dynamic>)
          .map((e) => AssetBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      themeMode: _parseThemeMode(json['themeMode'] as String?),
    );
  }

  static ThemeMode _parseThemeMode(String? value) {
    return ThemeMode.values.firstWhere(
      (item) => item.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
