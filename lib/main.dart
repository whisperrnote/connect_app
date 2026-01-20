import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const WhisperrConnectApp());
}

class WhisperrConnectApp extends StatelessWidget {
  const WhisperrConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhisperrConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LandingScreen(),
    );
  }
}
