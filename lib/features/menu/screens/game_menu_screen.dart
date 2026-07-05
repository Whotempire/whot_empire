import 'package:flutter/material.dart';
import '../../../widgets/menu_button.dart';
import '../../whot/screens/offline_game_screen.dart';

class GameMenuPage extends StatelessWidget {
  const GameMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      appBar: AppBar(
        title: const Text('Choose Game Mode'),
        backgroundColor: Colors.green.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              title: 'Offline Play',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OfflineGamePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const MenuButton(title: 'Online Play'),
            const SizedBox(height: 16),
            const MenuButton(title: 'Settings'),
          ],
        ),
      ),
    );
  }
}
