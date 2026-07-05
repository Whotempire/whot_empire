import 'dart:math';
import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}

class WhotCard {
  final String shape;
  final int number;

  WhotCard({required this.shape, required this.number});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openGameMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameMenuPage()),
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
            const Icon(Icons.style, size: 110, color: Colors.white),
            const SizedBox(height: 8),
            const Text(
              'WHOT EMPIRE',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => openGameMenu(context),
              child: const Text('PLAY'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const MenuButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

int pendingPick = 0;
bool holdOnActive = false;

class OfflineGamePage extends StatefulWidget {
  const OfflineGamePage({super.key});

  @override
  State<OfflineGamePage> createState() => _OfflineGamePageState();
}

class _OfflineGamePageState extends State<OfflineGamePage> {
  List<WhotCard> deck = [];
  List<WhotCard> playerCards = [];
  List<WhotCard> computerCards = [];
  List<WhotCard> discardPile = [];

  bool playerTurn = true;
  String gameStatus = 'Your Turn';
  
String? requestedShape;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    deck = buildDeck();
    deck.shuffle(Random());

    playerCards = deck.take(6).toList();
    deck.removeRange(0, 6);

    computerCards = deck.take(6).toList();
    deck.removeRange(0, 6);

    discardPile = [deck.first];
    deck.removeAt(0);

    playerTurn = true;
    gameStatus = 'Your Turn';
    requestedShape = null;

    setState(() {});
  }

  List<WhotCard> buildDeck() {
    final List<WhotCard> cards = [];
    final shapes = ['Circle', 'Triangle', 'Cross', 'Square', 'Star'];
    final numbers = [1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 14];

    for (final shape in shapes) {
      for (final number in numbers) {
        cards.add(WhotCard(shape: shape, number: number));
      }
    }

    cards.add(WhotCard(shape: 'Whot', number: 20));
    cards.add(WhotCard(shape: 'Whot', number: 20));

    return cards;
  }

  bool canPlay(WhotCard card) {
  final topCard = discardPile.last;

  if (card.number == 20) {
    return true;
  }

  if (requestedShape != null) {
    return card.shape == requestedShape;
  }

  return card.shape == topCard.shape || card.number == topCard.number;
}

void drawCards(List<WhotCard> hand, int amount) {
  for (int i = 0; i < amount; i++) {
    if (deck.isNotEmpty) {
      hand.add(deck.first);
      deck.removeAt(0);
    }
  }
}


  Future<void> playCard(WhotCard card) async {
    if (!playerTurn) return;

    if (!canPlay(card)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot play this card')),
      );
      return;
    }

    setState(() {
      playerCards.remove(card);
      discardPile.add(card);
    });

if (card.number == 20) {
  await chooseRequestedShape();
  return;
}

    if (playerCards.isEmpty) {
      setState(() {
        gameStatus = 'You Win!';
        playerTurn = false;
      });
      return;
    }

    if (card.number == 1) {
      setState(() {
        gameStatus = 'Hold On! Play again';
        playerTurn = true;
      });
      return;
    }

    if (card.number == 2) {
      setState(() {
        drawCards(computerCards, 2);
        gameStatus = 'Computer picked 2 cards. Play again';
        playerTurn = true;
      });
      return;
    }

    if (card.number == 5) {
      setState(() {
        drawCards(computerCards, 3);
        gameStatus = 'Computer picked 3 cards. Play again';
        playerTurn = true;
      });
      return;
    }

if (card.number == 8) {
  setState(() {
    gameStatus = 'Suspension! Computer loses turn. Play again';
    playerTurn = true;
  });
  return;
}

if (card.number == 14) {
  setState(() {
    drawCards(computerCards, 1);
    gameStatus = 'General Market! Computer picked 1 card. Play again';
    playerTurn = true;
  });
  return;
}

    setState(() {
      playerTurn = false;
      gameStatus = 'Computer Thinking...';
    });

    Future.delayed(const Duration(seconds: 1), () {
      computerPlay();
    });
  }

  void computerPlay() {
    if (playerCards.isEmpty || computerCards.isEmpty) return;

    final playableCards = computerCards.where((card) => canPlay(card)).toList();

    if (playableCards.isEmpty) {
      setState(() {
        if (deck.isNotEmpty) {
          computerCards.add(deck.first);
          deck.removeAt(0);
          gameStatus = 'Computer drew a card';
        } else {
          gameStatus = 'Deck is empty';
        }
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          playerTurn = true;
          gameStatus = 'Your Turn';
        });
      });
      return;
    }

    final cardToPlay = playableCards.first;

    setState(() {
      computerCards.remove(cardToPlay);
      discardPile.add(cardToPlay);
      gameStatus = 'Computer played ${cardToPlay.shape} ${cardToPlay.number}';
    });

    if (computerCards.isEmpty) {
      setState(() {
        gameStatus = 'Computer Wins!';
        playerTurn = false;
      });
      return;
    }

    if (cardToPlay.number == 1) {
      setState(() {
        gameStatus = 'Computer used Hold On';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), () {
        computerPlay();
      });
      return;
    }

    if (cardToPlay.number == 2) {
      setState(() {
        drawCards(playerCards, 2);
        gameStatus = 'Computer played Pick Two. You picked 2 cards';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), () {
        computerPlay();
      });
      return;
    }

    if (cardToPlay.number == 5) {
      setState(() {
        drawCards(playerCards, 3);
        gameStatus = 'Computer played Pick Three. You picked 3 cards';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), () {
        computerPlay();
      });
      return;
    }

    if (cardToPlay.number == 8) {
  setState(() {
    gameStatus = 'Computer used Suspension. Your turn is skipped';
    playerTurn = false;
  });

  Future.delayed(const Duration(seconds: 1), () {
    computerPlay();
  });
  return;
}

if (cardToPlay.number == 14) {
  setState(() {
    drawCards(playerCards, 1);
    gameStatus = 'Computer used General Market. You picked 1 card';
    playerTurn = false;
  });

  Future.delayed(const Duration(seconds: 1), () {
    computerPlay();
  });
  return;
}

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        playerTurn = true;
        gameStatus = 'Your Turn';
      });
    });
  }

Future<void> chooseRequestedShape() async {
  setState(() {
    gameStatus = 'WHOT played - choose a shape';
  });

  String selectedShape = 'Circle';

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Choose Shape'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                selectedShape = 'Circle';
                Navigator.pop(context);
              },
              child: const Text('Circle'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedShape = 'Triangle';
                Navigator.pop(context);
              },
              child: const Text('Triangle'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedShape = 'Cross';
                Navigator.pop(context);
              },
              child: const Text('Cross'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedShape = 'Square';
                Navigator.pop(context);
              },
              child: const Text('Square'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedShape = 'Star';
                Navigator.pop(context);
              },
              child: const Text('Star'),
            ),
          ],
        ),
      );
    },
  );

  setState(() {
    discardPile.add(
      WhotCard(
        shape: selectedShape,
        number: 20,
      ),
    );

    playerTurn = false;
    gameStatus = 'Computer Thinking...';
  });

  Future.delayed(const Duration(seconds: 1), () {
    computerPlay();
  });
}

  void drawCard() {
    if (!playerTurn) return;
    if (deck.isEmpty) return;

    setState(() {
      playerCards.add(deck.first);
      deck.removeAt(0);
      playerTurn = false;
      gameStatus = 'Computer Thinking...';
    });

    Future.delayed(const Duration(seconds: 1), () {
      computerPlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topCard = discardPile.last;

    return Scaffold(
      backgroundColor: Colors.green.shade700,
      appBar: AppBar(
        title: const Text('Offline Match'),
        backgroundColor: Colors.green.shade900,
        actions: [
          IconButton(
            onPressed: startNewGame,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            gameStatus,
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
         
         
          Column(
  children: [
    const CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: 32,
      ),
    ),
    const SizedBox(height: 6),
    const Text(
      'Computer',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      '${computerCards.length} Cards',
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    ),
  ],
),


          const SizedBox(height: 10),
          const Text(
            'Top Card',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          WhotCardWidget(card: topCard),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: playerTurn ? drawCard : null,
            child: const Text('Draw Card'),
          ),
          const SizedBox(height: 20),
          Text(
            'Your Cards: ${playerCards.length}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 115,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playerCards.length,
              itemBuilder: (context, index) {
                final card = playerCards[index];

                return GestureDetector(
                  onTap: () => playCard(card),
                  child: WhotCardWidget(card: card),
                );
              },
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}

class WhotCardWidget extends StatelessWidget {
  final WhotCard card;

  const WhotCardWidget({super.key, required this.card});

  IconData getShapeIcon() {
    switch (card.shape) {
      case 'Circle':
        return Icons.circle;
      case 'Triangle':
        return Icons.change_history;
      case 'Cross':
        return Icons.close;
      case 'Square':
        return Icons.square;
      case 'Star':
        return Icons.star;
      default:
        return Icons.style;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWhot = card.number == 20;

    return Container(
      width: 68,
      height: 95,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: isWhot ? Colors.red.shade700 : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(2, 3),
            color: Colors.black45,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isWhot ? Icons.style : getShapeIcon(),
            size: 24,
            color: isWhot ? Colors.white : Colors.black,
          ),
          const SizedBox(height: 2),
          Text(
            isWhot ? 'WHOT' : card.shape,
            style: TextStyle(
              fontSize: isWhot ? 17 : 12,
              fontWeight: FontWeight.bold,
              color: isWhot ? Colors.white : Colors.black,
            ),
          ),
          Text(
            '${card.number}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isWhot ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}