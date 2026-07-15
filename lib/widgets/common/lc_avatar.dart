import 'package:flutter/material.dart';

class LCAvatar extends StatelessWidget {
  final String name;

  const LCAvatar({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: Icon(Icons.person, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
