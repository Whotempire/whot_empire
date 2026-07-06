import 'package:whot_empire/features/whot/models/whot_card.dart';

class DeckGenerator {
  static List<WhotCard> generateDeck() {
    final deck = <WhotCard>[];

    void addCards(String shape, List<int> numbers) {
      for (final number in numbers) {
        deck.add(WhotCard(shape: shape, number: number));
      }
    }

    addCards('Circle', [1, 2, 3, 4, 5, 7, 8, 10, 11, 13, 14]);
    addCards('Triangle', [1, 2, 3, 4, 5, 7, 8, 10, 11, 13, 14]);
    addCards('Square', [1, 2, 3, 5, 7, 10, 11, 13, 14]);
    addCards('Cross', [1, 2, 3, 5, 7, 10, 11, 13, 14]);
    addCards('Star', [1, 2, 3, 4, 5, 7, 8]);

    for (int i = 0; i < 5; i++) {
      deck.add(WhotCard(shape: 'Whot', number: 20));
    }

    return deck;
  }

  static List<WhotCard> shuffledDeck() {
    final deck = generateDeck();
    deck.shuffle();
    return deck;
  }
}
