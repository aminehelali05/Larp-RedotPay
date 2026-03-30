import 'package:flutter/material.dart';

/// Self-contained crypto icon widget — no network images needed.
class CryptoIcon extends StatelessWidget {
  const CryptoIcon({
    super.key,
    required this.symbol,
    this.size = 40,
  });

  final String symbol;
  final double size;

  static const Map<String, Color> _colors = {
    'USDT': Color(0xFF26A17B),
    'USDⓢ': Color(0xFF2BA845),
    'USDC': Color(0xFF2775CA),
    'BTC': Color(0xFFF7931A),
    'ETH': Color(0xFF627EEA),
    'SOL': Color(0xFF9945FF),
    'BNB': Color(0xFFF3BA2F),
    'SONIC': Color(0xFF5B7DF5),
    'XRP': Color(0xFF00AAE4),
    'ADA': Color(0xFF0033AD),
    'DOT': Color(0xFFE6007A),
    'AVAX': Color(0xFFE84142),
    'MATIC': Color(0xFF8247E5),
    'DOGE': Color(0xFFC2A633),
  };

  static const Map<String, String> _symbols = {
    'USDT': '₮',
    'USDⓢ': '\$',
    'USDC': '\$',
    'BTC': '₿',
    'ETH': 'Ξ',
    'SOL': 'S',
    'BNB': 'B',
    'SONIC': '◎',
    'XRP': 'X',
    'ADA': '₳',
    'DOT': '●',
    'AVAX': 'A',
    'MATIC': 'M',
    'DOGE': 'Ð',
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[symbol] ?? const Color(0xFF8D8E96);
    final glyph = _symbols[symbol] ?? symbol[0];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          glyph,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.48,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
