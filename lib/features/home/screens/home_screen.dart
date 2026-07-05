import 'package:flutter/material.dart';
import 'package:whot_empire/features/menu/screens/game_menu_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openGameMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameMenuPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF021F18),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.account_balance,
                color: Color(0xFFFFC857),
                size: 80,
              ),

              const SizedBox(height: 16),

              const Text(
                'WHOT EMPIRE',
                style: TextStyle(
                  color: Color(0xFFFFC857),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Rule the Table',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF063B2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFFFC857),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatBox(title: 'Coins', value: '2,000'),
                    _StatBox(title: 'Level', value: '1'),
                    _StatBox(title: 'Rank', value: 'Rookie'),
                  ],
                ),
              ),

              const Spacer(),

              _LobbyButton(
                title: 'Classic Whot',
                subtitle: 'Fast Nigerian card battle',
                icon: Icons.style,
                onTap: _openGameMenuStatic,
              ),

              const SizedBox(height: 16),

              const _LockedLobbyButton(
                title: 'Jackpot',
                subtitle: 'Team signals. Suspect. Win.',
                icon: Icons.groups,
              ),

              const SizedBox(height: 16),

              const _LockedLobbyButton(
                title: 'Tournaments',
                subtitle: 'Coming soon',
                icon: Icons.emoji_events,
              ),

              const Spacer(),

              const Text(
                'Welcome, King 👑',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _openGameMenuStatic(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameMenuPage(),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;

  const _StatBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFFFC857),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _LobbyButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function(BuildContext context) onTap;

  const _LobbyButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFFC857),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF021F18), size: 36),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF021F18),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF021F18),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF021F18),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LockedLobbyButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _LockedLobbyButton({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.55,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF063B2E),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 36),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.lock, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}