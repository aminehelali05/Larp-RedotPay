import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/state/app_state_controller.dart';
import '../features/navigation/shell_screen.dart';
import 'theme/app_theme.dart';

class RedotPayDemoApp extends ConsumerWidget {
  const RedotPayDemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    return MaterialApp(
      title: 'RedotPay Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appState.themeMode,
      home: const ShellScreen(),
    );
  }
}
