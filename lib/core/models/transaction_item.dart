class TransactionItem {
  const TransactionItem({
    required this.merchant,
    required this.maskedCard,
    required this.timestamp,
    required this.amountUsd,
    required this.status,
    required this.icon,
  });

  final String merchant;
  final String maskedCard;
  final String timestamp;
  final double amountUsd;
  final String status;
  final String icon;

  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant,
      'maskedCard': maskedCard,
      'timestamp': timestamp,
      'amountUsd': amountUsd,
      'status': status,
      'icon': icon,
    };
  }

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      merchant: json['merchant'] as String,
      maskedCard: json['maskedCard'] as String,
      timestamp: json['timestamp'] as String,
      amountUsd: (json['amountUsd'] as num).toDouble(),
      status: json['status'] as String,
      icon: json['icon'] as String,
    );
  }
}
