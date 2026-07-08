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
            const SizedBox(height: 20),
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

    return card.shape == topCard.shape ||
        card.number == topCard.number ||
        card.number == 20;
  }

  void playCard(WhotCard card) { if (!playerTurn) return;
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
  }

  void drawCard() {
    if (deck.isEmpty) return;

    setState(() {
      playerCards.add(deck.first);
      deck.removeAt(0);
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
        children: [ const SizedBox(height: 10),

Text(
  gameStatus,
  style: const TextStyle(
    color: Colors.yellow,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),
          const SizedBox(height: 20),
          Text(
            'Computer Cards: ${computerCards.length}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Spacer(),
          const Text(
            'Top Card',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          WhotCardWidget(card: topCard),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: drawCard,
            child: const Text('Draw Card'),
          ),
          const Spacer(),
          Text(
            'Your Cards: ${playerCards.length}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 125,
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class WhotCardWidget extends StatelessWidget {
  final WhotCard card;

  const WhotCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 105,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: card.number == 20 ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Center(
        child: Text(
          card.number == 20 ? 'WHOT\n20' : '${card.shape}\n${card.number}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: card.number == 20 ? 18 : 15,
            fontWeight: FontWeight.bold,
            color: card.number == 20 ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}