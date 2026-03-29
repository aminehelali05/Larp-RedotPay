class AssetBalance {
  const AssetBalance({
    required this.symbol,
    required this.name,
    required this.amount,
    required this.usdRate,
    required this.icon,
    this.showApprox = true,
  });

  final String symbol;
  final String name;
  final double amount;
  final double usdRate;
  final String icon;
  final bool showApprox;

  double get usdValue => amount * usdRate;

  AssetBalance copyWith({
    String? symbol,
    String? name,
    double? amount,
    double? usdRate,
    String? icon,
    bool? showApprox,
  }) {
    return AssetBalance(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      usdRate: usdRate ?? this.usdRate,
      icon: icon ?? this.icon,
      showApprox: showApprox ?? this.showApprox,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'amount': amount,
      'usdRate': usdRate,
      'icon': icon,
      'showApprox': showApprox,
    };
  }

  factory AssetBalance.fromJson(Map<String, dynamic> json) {
    return AssetBalance(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      usdRate: (json['usdRate'] as num).toDouble(),
      icon: json['icon'] as String,
      showApprox: (json['showApprox'] as bool?) ?? true,
    );
  }
}
