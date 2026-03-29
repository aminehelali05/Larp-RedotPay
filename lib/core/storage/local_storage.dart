import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../state/app_state.dart';

class LocalStorage {
  static const _stateKey = 'demo_app_state_v1';

  Future<DemoAppState?> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_stateKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final map = jsonDecode(raw) as Map<String, dynamic>;
    return DemoAppState.fromJson(map);
  }

  Future<void> saveState(DemoAppState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_stateKey, jsonEncode(state.toJson()));
  }
}
