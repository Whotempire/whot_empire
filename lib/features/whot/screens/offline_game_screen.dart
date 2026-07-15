import 'dart:math';
import 'package:flutter/material.dart';

import '../models/whot_card.dart';
import '../../../widgets/whot_card_widget.dart';
import '../engine/deck_generator.dart';
import 'package:whot_empire/widgets/game/empire_whot_card.dart';
import 'package:whot_empire/core/design_system/colors.dart';
import 'package:whot_empire/widgets/common/lc_section_title.dart';
import 'package:whot_empire/widgets/common/lc_button.dart';
import 'package:whot_empire/widgets/common/lc_avatar.dart';


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

    playerCards = deck.take(5).toList();
deck.removeRange(0, 5);

computerCards = deck.take(5).toList();
deck.removeRange(0, 5);

    discardPile = [deck.first];
    deck.removeAt(0);

    playerTurn = true;
    gameStatus = 'Your Turn';
    requestedShape = null;

    setState(() {});
  }

  List<WhotCard> buildDeck() {
  return DeckGenerator.shuffledDeck();
}

  bool canPlay(WhotCard card) {
    final topCard = discardPile.last;

    if (card.number == 20) return true;

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

    Future.delayed(const Duration(seconds: 1), computerPlay);
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

      Future.delayed(const Duration(seconds: 1), computerPlay);
      return;
    }

    if (cardToPlay.number == 2) {
      setState(() {
        drawCards(playerCards, 2);
        gameStatus = 'Computer played Pick Two. You picked 2 cards';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), computerPlay);
      return;
    }

    if (cardToPlay.number == 5) {
      setState(() {
        drawCards(playerCards, 3);
        gameStatus = 'Computer played Pick Three. You picked 3 cards';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), computerPlay);
      return;
    }

    if (cardToPlay.number == 8) {
      setState(() {
        gameStatus = 'Computer used Suspension. Your turn is skipped';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), computerPlay);
      return;
    }

    if (cardToPlay.number == 14) {
      setState(() {
        drawCards(playerCards, 1);
        gameStatus = 'Computer used General Market. You picked 1 card';
        playerTurn = false;
      });

      Future.delayed(const Duration(seconds: 1), computerPlay);
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
              _shapeButton('Circle', (value) {
                selectedShape = value;
                Navigator.pop(context);
              }),
              _shapeButton('Triangle', (value) {
                selectedShape = value;
                Navigator.pop(context);
              }),
              _shapeButton('Cross', (value) {
                selectedShape = value;
                Navigator.pop(context);
              }),
              _shapeButton('Square', (value) {
                selectedShape = value;
                Navigator.pop(context);
              }),
              _shapeButton('Star', (value) {
                selectedShape = value;
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );

    setState(() {
      discardPile.add(WhotCard(shape: selectedShape, number: 20));
      playerTurn = false;
      gameStatus = 'Computer Thinking...';
    });

    Future.delayed(const Duration(seconds: 1), computerPlay);
  }

  Widget _shapeButton(String shape, void Function(String) onSelected) {
  return ElevatedButton(
    onPressed: () => onSelected(shape),
    child: Text(shape),
  );
}

  void drawCard() {
    if (!playerTurn || deck.isEmpty) return;

    setState(() {
      playerCards.add(deck.first);
      deck.removeAt(0);
      playerTurn = false;
      gameStatus = 'Computer Thinking...';
    });

    Future.delayed(const Duration(seconds: 1), computerPlay);
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
    body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 6),
          Text(
            gameStatus,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 4),
          const Text(
            'Computer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${computerCards.length} Cards',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          const Text(
            'Battle Table',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text('Top Card', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  WhotCardWidget(card: topCard),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                children: [
                  const Text('Draw Deck', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: playerTurn ? drawCard : null,
                    child: Container(
                      width: 70,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: const Center(
                        child: Icon(Icons.style, color: Colors.amber),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: playerTurn ? drawCard : null,
            child: const Text('Draw Card'),
          ),
          const SizedBox(height: 6),
          Text(
            'Your Cards: ${playerCards.length}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 100,
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
        ],
      ),
    ),
  );
}
}