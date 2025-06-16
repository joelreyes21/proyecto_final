import 'package:flutter/material.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const EntreTazasApp());
}

class EntreTazasApp extends StatelessWidget {
  const EntreTazasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
