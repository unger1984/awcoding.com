import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final bool active;
  final bool main;

  const MenuButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.active = false,
    this.main = false,
  }) : super(key: key);

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
    final bgColor = widget.main ? Colors.white : const Color(0xff1d2428);
    final fontColor = widget.main ? const Color(0xff1d2428) : Colors.white;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextButton(
        onPressed: widget.onPressed,
        onHover: handleHover,
        style: TextButton.styleFrom(
          backgroundColor:
              isHover || widget.active ? bgColor : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            widget.title,
            style: TextStyle(
              color: isHover || widget.active
                  ? fontColor
                  : bgColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
