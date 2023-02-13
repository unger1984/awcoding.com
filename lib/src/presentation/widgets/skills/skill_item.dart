import 'package:flutter/material.dart';

@immutable
class SkillItem extends StatelessWidget {
  final String img;
  final String title;

  const SkillItem({Key? key, required this.title, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/$img.png',
            width: 85,
            height: 85,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ],
      ),
    );
  }
}
