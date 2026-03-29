import 'package:flutter/material.dart';

import '../admin/admin_panel_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  int _secretLongPressCount = 0;
  int _secretCornerTapCount = 0;

  void _openAdmin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminPanelScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Text('Profile', style: textTheme.headlineLarge?.copyWith(fontSize: 44)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFF2A2D36),
                    child: Icon(Icons.person, size: 44, color: Colors.white54),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onLongPress: () {
                      _secretLongPressCount++;
                      if (_secretLongPressCount >= 7) {
                        _secretLongPressCount = 0;
                        _openAdmin();
                      }
                    },
                    child: Text('ami****@gmail.com', style: textTheme.headlineLarge?.copyWith(fontSize: 34)),
                  ),
                  const SizedBox(height: 5),
                  Text('UID: 1107037434', style: textTheme.bodySmall),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  _settingRow('Security'),
                  _settingRow('Payment settings'),
                  _settingRow('Community'),
                  _settingRow('Share'),
                  _settingRow('About us'),
                ],
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: GestureDetector(
                onTap: () {
                  _secretCornerTapCount++;
                  if (_secretCornerTapCount >= 5) {
                    _secretCornerTapCount = 0;
                    _openAdmin();
                  }
                },
                child: Container(
                  width: 10,
                  height: 10,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingRow(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
