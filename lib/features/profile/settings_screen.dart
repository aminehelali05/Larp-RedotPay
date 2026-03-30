import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../core/widgets/scale_button.dart';
import '../admin/admin_panel_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _supportIdCtrl = TextEditingController();

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  void _checkSecretCode() {
    if (_supportIdCtrl.text.trim().toLowerCase() == 'flex2026') {
      _supportIdCtrl.clear();
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
  }

  @override
  void dispose() {
    _supportIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Header ───
                    ScaleButton(
                      onTap: () => Navigator.pop(context),
                      child:
                          const Icon(Icons.arrow_back_rounded, size: 24),
                    ),
                    const SizedBox(height: 16),
                    Text('Settings',
                        style: textTheme.headlineLarge
                            ?.copyWith(fontSize: 30)),
                    const SizedBox(height: 28),

                    // ─── Settings Rows ───
                    _settingRow(
                      icon: Icons.toll_outlined,
                      label: 'Currency',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🇺🇸',
                              style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 6),
                          Text('USD',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right,
                              color: AppColors.textMuted, size: 20),
                        ],
                      ),
                      onTap: () => _showSnack('Currency settings'),
                    ),
                    _divider(),
                    _settingRow(
                      icon: Icons.language_rounded,
                      label: 'Language',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('English US',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right,
                              color: AppColors.textMuted, size: 20),
                        ],
                      ),
                      onTap: () => _showSnack('Language settings'),
                    ),
                    _divider(),
                    _settingRow(
                      icon: Icons.brightness_6_outlined,
                      label: 'Appearance',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('System',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right,
                              color: AppColors.textMuted, size: 20),
                        ],
                      ),
                      onTap: () => _showSnack('Appearance settings'),
                    ),
                    _divider(),
                    _settingRow(
                      icon: Icons.notifications_none_rounded,
                      label: 'Marketing preferences',
                      onTap: () => _showSnack('Marketing preferences'),
                    ),
                    _divider(),
                    _settingRow(
                      icon: Icons.settings_outlined,
                      label: 'Permissions',
                      onTap: () => _showSnack('Permissions'),
                    ),
                    _divider(),
                    _settingRow(
                      icon: Icons.wifi_rounded,
                      label: 'Network diagnostics',
                      onTap: () => _showSnack('Network diagnostics'),
                    ),
                    _divider(),

                    // ─── Hidden Support ID field ───
                    const SizedBox(height: 24),
                    TextField(
                      controller: _supportIdCtrl,
                      onSubmitted: (_) => _checkSecretCode(),
                      style: textTheme.bodySmall
                          ?.copyWith(fontSize: 12, color: AppColors.textMuted),
                      decoration: InputDecoration(
                        hintText: 'Support ID (optional)',
                        hintStyle: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.textMuted.withAlpha(80),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        filled: true,
                        fillColor: AppColors.surfaceDark.withAlpha(60),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ─── Log Out Button ───
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
              child: ScaleButton(
                onTap: () => _showSnack('Log out (demo mode)'),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Log out',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingRow({
    required IconData icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ScaleButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
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

  Widget _divider() {
    return const Divider(height: 1, color: AppColors.divider);
  }
}
