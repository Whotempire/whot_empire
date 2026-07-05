import 'game_state.dart';

class GameEngine {
  final GameState state = GameState();

  void startGame() {
    state.status = GameStatus.playing;
    state.currentTurn = Turn.player;
    state.message = "Your Turn";
  }

  void changeTurn() {
    if (state.currentTurn == Turn.player) {
      state.currentTurn = Turn.computer;
      state.message = "Computer's Turn";
    } else {
      state.currentTurn = Turn.player;
      state.message = "Your Turn";
    }
  }

  void gameOver() {
    state.status = GameStatus.gameOver;
    state.message = "The Throne Is Yours 👑";
  }
}