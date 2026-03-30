import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../core/widgets/scale_button.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ───
            Row(
              children: [
                Text('Send',
                    style: textTheme.headlineLarge?.copyWith(fontSize: 30)),
                const SizedBox(width: 12),
                _buildPill(context, 'to bank or wallet'),
                const Spacer(),
                ScaleButton(
                  onTap: () => _snack(context, 'QR Scanner'),
                  child: const Icon(Icons.qr_code_scanner_rounded,
                      size: 22, color: Colors.white),
                ),
                const SizedBox(width: 14),
                ScaleButton(
                  onTap: () => _snack(context, 'Help center'),
                  child: const Icon(Icons.help_outline_rounded,
                      size: 22, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ─── You Send ───
            Text('You send',
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 12),
            Row(
              children: [
                _currencyPill(
                  context,
                  color: const Color(0xFF26A17B),
                  symbol: '₮',
                  label: 'USDT',
                ),
                const Spacer(),
                Text('Available 3 USDT',
                    style: textTheme.bodySmall?.copyWith(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '1,000.00',
              style: textTheme.headlineLarge?.copyWith(
                fontSize: 44,
                color: const Color(0xFF3F4149),
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
            Divider(height: 36, color: AppColors.divider.withAlpha(100)),

            // ─── Recipient Gets ───
            Text('Recipient gets',
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 12),
            _currencyPill(
              context,
              color: null,
              symbol: '🇺🇸',
              label: 'USD',
              isFlag: true,
            ),
            const SizedBox(height: 8),
            Text(
              '944.87',
              style: textTheme.headlineLarge?.copyWith(
                fontSize: 44,
                color: const Color(0xFF3F4149),
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 14),
            Divider(height: 1, color: AppColors.divider.withAlpha(100)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '1 USDT  =  0.9893 USD',
                style: textTheme.bodySmall?.copyWith(fontSize: 13),
              ),
            ),

            const Spacer(),

            // ─── Continue Button ───
            ScaleButton(
              onTap: () => _snack(context, 'Insufficient balance'),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF20232D),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text('Continue',
                    style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textMuted, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(BuildContext context, String text) {
    return ScaleButton(
      onTap: () => _snack(context, 'Select destination'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1F222B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text,
                style: const TextStyle(fontSize: 13, color: Colors.white70)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down,
                size: 18, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _currencyPill(
    BuildContext context, {
    required Color? color,
    required String symbol,
    required String label,
    bool isFlag = false,
  }) {
    return ScaleButton(
      onTap: () => _snack(context, 'Select currency'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1F222B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF3A3D46), width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isFlag)
              Text(symbol, style: const TextStyle(fontSize: 18))
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(symbol,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down,
                size: 18, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
