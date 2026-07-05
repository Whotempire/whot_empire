import 'package:flutter/material.dart';


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
