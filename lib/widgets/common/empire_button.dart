import 'package:flutter/material.dart';

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
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}