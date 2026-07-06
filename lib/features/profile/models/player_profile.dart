class PlayerProfile {
  final String name;
  final String rank;
  final int level;
  final int empireGold;
  final int gamesPlayed;
  final int gamesWon;
  final int crownStreak;

  const PlayerProfile({
    required this.name,
    required this.rank,
    required this.level,
    required this.empireGold,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.crownStreak,
  });

  double get winRate {
    if (gamesPlayed == 0) return 0;
    return gamesWon / gamesPlayed;
  }
}