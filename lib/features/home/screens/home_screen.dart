import 'package:flutter/material.dart';
import '../../menu/screens/game_menu_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openGameMenu(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GameMenuPage(),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.style, color: Colors.white, size: 100),
            const SizedBox(height: 20),
            const Text(
              'WHOT EMPIRE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => _openGameMenu(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text('PLAY', style: TextStyle(fontSize: 22)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}