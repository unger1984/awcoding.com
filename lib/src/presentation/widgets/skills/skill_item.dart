import 'package:flutter/material.dart';

@immutable
class SkillItem extends StatelessWidget {
  final String img;
  final String title;

  const SkillItem({super.key, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/$img.png',
            semanticLabel: img,
            width: 85,
            height: 85,
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontFamily: 'Montserrat')),
        ],
      ),
    );
  }
}
