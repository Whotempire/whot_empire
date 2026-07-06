import 'package:whot_empire/features/profile/models/player_profile.dart';

class PlayerService {
  static PlayerProfile currentPlayer = const PlayerProfile(
    name: 'King Onyeka',
    rank: 'Village Apprentice',
    level: 1,
    empireGold: 2000,
    gamesPlayed: 0,
    gamesWon: 0,
    crownStreak: 0,
  );
}