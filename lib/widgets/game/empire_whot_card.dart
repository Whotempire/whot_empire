import 'package:flutter/material.dart';
import 'package:whot_empire/core/theme/app_colors.dart';
import 'package:whot_empire/features/whot/models/whot_card.dart';

class EmpireWhotCard extends StatelessWidget {
  final WhotCard card;
  final bool faceDown;

  const EmpireWhotCard({
    super.key,
    required this.card,
    this.faceDown = false,
  });

  @override
  Widget build(BuildContext context) {
    final isWhot = card.number == 20;

    return Container(
      width: 76,
      height: 108,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: faceDown
            ? AppColors.deepEmerald
            : isWhot
                ? AppColors.royalBlack
                : AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.royalGold,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: faceDown ? _buildBack() : _buildFront(isWhot),
    );
  }

  Widget _buildBack() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance, color: AppColors.royalGold, size: 30),
          SizedBox(height: 6),
          Text(
            'WHOT',
            style: TextStyle(
              color: AppColors.royalGold,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(bool isWhot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isWhot ? Icons.account_balance : _shapeIcon(),
          color: isWhot ? AppColors.royalGold : _shapeColor(),
          size: 30,
        ),
        const SizedBox(height: 6),
        Text(
          isWhot ? 'WHOT' : card.shape,
          style: TextStyle(
            color: isWhot ? AppColors.royalGold : AppColors.royalBlack,
            fontWeight: FontWeight.bold,
            fontSize: isWhot ? 15 : 12,
          ),
        ),
        Text(
          '${card.number}',
          style: TextStyle(
            color: isWhot ? AppColors.royalGold : AppColors.royalBlack,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  IconData _shapeIcon() {
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

  Color _shapeColor() {
    switch (card.shape) {
      case 'Circle':
        return AppColors.emerald;
      case 'Triangle':
        return Colors.redAccent;
      case 'Cross':
        return Colors.blueAccent;
      case 'Square':
        return Colors.deepPurple;
      case 'Star':
        return AppColors.royalGold;
      default:
        return AppColors.royalBlack;
    }
  }
}