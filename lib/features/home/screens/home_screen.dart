import 'package:flutter/material.dart';
import 'package:whot_empire/features/menu/screens/game_menu_screen.dart';
import 'package:whot_empire/features/profile/screens/profile_screen.dart';
import 'package:whot_empire/widgets/common/empire_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openGameMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameMenuPage()),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF021F18),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Icon(Icons.account_balance, color: Color(0xFFFFC857), size: 72),
              const SizedBox(height: 12),
              const Text(
                'LAST CARD EMPIRE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFFC857),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 6),
              const Text('Rule the Table', style: TextStyle(color: Colors.white70, fontSize: 18)),
              const SizedBox(height: 24),
              EmpireButton(
                title: 'Classic Whot',
                icon: Icons.style,
                onPressed: () => _openGameMenu(context),
              ),
              const SizedBox(height: 14),
              EmpireButton(
                title: 'Profile',
                icon: Icons.person,
                onPressed: () => _openProfile(context),
              ),
              const SizedBox(height: 20),
              const Text('Welcome, King 👑', style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
