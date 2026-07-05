enum Turn {
  player,
  computer,
}

enum GameStatus {
  waiting,
  playing,
  gameOver,
}

class GameState {
  Turn currentTurn;
  GameStatus status;

  String message;
  String? requestedShape;

  bool holdOnActive;
  bool pickTwoActive;
  bool pickThreeActive;
  bool suspensionActive;

  GameState({
    this.currentTurn = Turn.player,
    this.status = GameStatus.waiting,
    this.message = 'Your Turn',
    this.requestedShape,
    this.holdOnActive = false,
    this.pickTwoActive = false,
    this.pickThreeActive = false,
    this.suspensionActive = false,
  });

  bool get isPlayerTurn => currentTurn == Turn.player;
  bool get isComputerTurn => currentTurn == Turn.computer;
  bool get isGameOver => status == GameStatus.gameOver;
}