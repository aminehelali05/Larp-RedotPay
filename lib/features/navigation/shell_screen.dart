import 'package:flutter/material.dart';

import '../assets/assets_screen.dart';
import '../card/card_screen.dart';
import '../home/home_screen.dart';
import '../send/send_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  final _tabs = const [
    HomeScreen(),
    CardScreen(),
    SendScreen(),
    AssetsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: const Color(0xFF5B5D66), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: 'Home',
                selected: _index == 0,
                onTap: () => setState(() => _index = 0),
                color: colorScheme.primary,
              ),
              _NavItem(
                icon: Icons.credit_card,
                label: 'Card',
                selected: _index == 1,
                onTap: () => setState(() => _index = 1),
                color: colorScheme.primary,
              ),
              _NavItem(
                icon: Icons.arrow_right_alt_rounded,
                label: 'Send',
                selected: _index == 2,
                onTap: () => setState(() => _index = 2),
                color: colorScheme.primary,
              ),
              _NavItem(
                icon: Icons.account_balance_wallet,
                label: 'Assets',
                selected: _index == 3,
                onTap: () => setState(() => _index = 3),
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1B1D23) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 23, color: selected ? color : Colors.white),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected ? color : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
