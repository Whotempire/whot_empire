import 'package:flutter/material.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const WhotEmpireApp());
}

class WhotEmpireApp extends StatelessWidget {
  const WhotEmpireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whot Empire',
      home: HomePage(),
    );
  }
}