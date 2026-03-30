import 'package:flutter/material.dart';

import '../features/navigation/shell_screen.dart';
import '../features/splash/splash_screen.dart';
import 'theme/app_theme.dart';

class RedotPayDemoApp extends StatelessWidget {
  const RedotPayDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedotPay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: SplashScreen(nextScreen: const ShellScreen()),
    );
  }
}
