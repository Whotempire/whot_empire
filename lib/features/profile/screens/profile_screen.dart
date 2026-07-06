import 'package:flutter/material.dart';
import 'package:whot_empire/core/services/player_service.dart';
import 'package:whot_empire/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = PlayerService.currentPlayer;

    return Scaffold(
      backgroundColor: AppColors.royalBlack,
      appBar: AppBar(
        title: const Text('Royal Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.account_balance,
              color: AppColors.royalGold,
              size: 90,
            ),
            const SizedBox(height: 16),
            Text(
              player.name,
              style: const TextStyle(
                color: AppColors.royalGold,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              player.rank,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),

            _ProfileStat(title: 'Level', value: '${player.level}'),
            _ProfileStat(title: 'Empire Gold', value: '${player.empireGold}'),
            _ProfileStat(title: 'Games Played', value: '${player.gamesPlayed}'),
            _ProfileStat(title: 'Games Won', value: '${player.gamesWon}'),
            _ProfileStat(title: 'Crown Streak', value: '${player.crownStreak}'),
            _ProfileStat(
              title: 'Win Rate',
              value: '${(player.winRate * 100).toStringAsFixed(0)}%',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.deepEmerald,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.royalGold.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.royalGold,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}