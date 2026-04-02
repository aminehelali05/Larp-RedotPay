import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/app_theme.dart';
import '../../core/widgets/scale_button.dart';
import '../admin/admin_panel_screen.dart';
import 'settings_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  int _secretLongPressCount = 0;

  void _openAdmin() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AdminPanelScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header ───
              Row(
                children: [
                  ScaleButton(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_rounded, size: 24),
                  ),
                  const Spacer(),
                  ScaleButton(
                    onTap: () => _showSnack('Support'),
                    child: const Icon(Icons.headset_mic_outlined, size: 22),
                  ),
                  const SizedBox(width: 16),
                  ScaleButton(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const SettingsScreen()),
                    ),
                    child: const Icon(Icons.settings_outlined, size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ─── Profile Info ───
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          _secretLongPressCount++;
                          if (_secretLongPressCount >= 7) {
                            _secretLongPressCount = 0;
                            _openAdmin();
                          } else {
                            HapticFeedback.lightImpact();
                          }
                        },
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: const Color(0xFF2A2D36),
                          child: Text(
                            'AF',
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brandRed,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            _secretLongPressCount++;
                            if (_secretLongPressCount >= 7) {
                              _secretLongPressCount = 0;
                              _openAdmin();
                            } else {
                              HapticFeedback.lightImpact();
                            }
                          },
                          child: Text(
                            'AmineFlex',
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ami****@flex.tn',
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'UID: RPX-987654',
                              style: textTheme.bodySmall
                                  ?.copyWith(fontSize: 13),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(const ClipboardData(
                                    text: 'RPX-987654'));
                                _showSnack('UID copied!');
                              },
                              child: const Icon(Icons.copy_rounded,
                                  size: 14,
                                  color: AppColors.textMuted),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.green.withAlpha(30),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Verified ✓',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: AppColors.textMuted),
                ],
              ),
              const SizedBox(height: 24),

              // ─── Referral Card ───
              ScaleButton(
                onTap: () => _showSnack('Referral program'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.divider, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.brandRed.withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.people_rounded,
                            color: AppColors.brandRed, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Referral',
                                style: textTheme.titleMedium
                                    ?.copyWith(fontSize: 15)),
                            const SizedBox(height: 2),
                            Text(
                              'Earn up to 40% commission\nby inviting friends',
                              style: textTheme.bodySmall
                                  ?.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('Invite now',
                            style: textTheme.bodyMedium
                                ?.copyWith(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ─── Menu Items ───
              _menuItem(
                icon: Icons.lock_outline_rounded,
                label: 'Security',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _dot(AppColors.green),
                    const SizedBox(width: 3),
                    _dot(AppColors.green),
                    const SizedBox(width: 3),
                    _dot(AppColors.green),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textMuted, size: 20),
                  ],
                ),
                onTap: () => _showSnack('Security settings'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.toll_outlined,
                label: 'Payment settings',
                onTap: () => _showSnack('Payment settings'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.swap_horiz_rounded,
                label: 'P2P Trading',
                onTap: () => _showSnack('P2P Trading'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Community',
                onTap: () => _showSnack('Community'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.card_giftcard_rounded,
                label: 'Rewards',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('NEW', style: textTheme.bodySmall?.copyWith(
                        fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textMuted, size: 20),
                  ],
                ),
                onTap: () => _showSnack('Rewards'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.ios_share_rounded,
                label: 'Share',
                onTap: () => _showSnack('Share'),
              ),
              _menuDivider(),
              _menuItem(
                icon: Icons.info_outline_rounded,
                label: 'About us',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('V3.1.0',
                        style: textTheme.bodySmall
                            ?.copyWith(fontSize: 13)),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textMuted, size: 20),
                  ],
                ),
                onTap: () => _showSnack('About RedotPay V3.1.0'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ScaleButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.white70),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 15)),
            ),
            trailing ??
                const Icon(Icons.chevron_right,
                    color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuDivider() {
    return const Divider(height: 1, color: AppColors.divider);
  }

  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
