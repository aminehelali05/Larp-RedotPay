import 'package:flutter/material.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Send', style: textTheme.headlineLarge?.copyWith(fontSize: 54)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F222B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text('to bank or wallet'),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text('You send', style: textTheme.titleLarge?.copyWith(color: const Color(0xFF8D8E96))),
            const SizedBox(height: 6),
            Text('1,000.00', style: textTheme.headlineLarge?.copyWith(fontSize: 82, color: const Color(0xFF3F4149))),
            const Divider(height: 40),
            Text('Recipient gets', style: textTheme.titleLarge?.copyWith(color: const Color(0xFF8D8E96))),
            const SizedBox(height: 6),
            Text('944.87', style: textTheme.headlineLarge?.copyWith(fontSize: 82, color: const Color(0xFF3F4149))),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF20232D),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text('Continue', style: textTheme.titleLarge?.copyWith(color: const Color(0xFF8D8E96))),
            ),
          ],
        ),
      ),
    );
  }
}
