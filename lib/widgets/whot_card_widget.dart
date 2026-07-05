import 'package:flutter/material.dart';
import '../features/whot/models/whot_card.dart';

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