import '../models/card_shape.dart';
import '../models/whot_card.dart';

class DeckGenerator {
  static List<WhotCard> generateDeck() {
    final deck = <WhotCard>[];

    void addCards(CardShape shape, List<int> numbers) {
      for (final number in numbers) {
        deck.add(WhotCard(shape: shape, number: number));
      }
    }

    addCards(CardShape.circle, [1, 2, 3, 4, 5, 7, 8, 10, 11, 13, 14]);
    addCards(CardShape.triangle, [1, 2, 3, 4, 5, 7, 8, 10, 11, 13, 14]);
    addCards(CardShape.square, [1, 2, 3, 5, 7, 10, 11, 13, 14]);
    addCards(CardShape.cross, [1, 2, 3, 5, 7, 10, 11, 13, 14]);
    addCards(CardShape.star, [1, 2, 3, 4, 5, 7, 8]);

    for (int i = 0; i < 5; i++) {
      deck.add(const WhotCard(shape: CardShape.whot, number: 20));
    }

    return deck;
  }

  static List<WhotCard> shuffledDeck() {
    final deck = generateDeck();
    deck.shuffle();
    return deck;
  }
}