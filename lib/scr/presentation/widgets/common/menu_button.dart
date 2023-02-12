import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;

  const MenuButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isHover = false;

  void handleHover(bool hover) {
    setState(() {
      isHover = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      onHover: handleHover,
      style: TextButton.styleFrom(
        backgroundColor: isHover ? Colors.white : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          widget.title,
          style: TextStyle(
            color: isHover ? Colors.black : Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
