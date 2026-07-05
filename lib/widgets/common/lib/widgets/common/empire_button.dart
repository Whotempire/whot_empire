import 'package:flutter/material.dart';
import 'package:whot_empire/core/theme/app_colors.dart';

class EmpireButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const EmpireButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.royalGold,
          foregroundColor: AppColors.royalBlack,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}