import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final bool active;
  final bool main;

  const MenuButton({Key? key, required this.title, required this.onPressed, this.active = false, this.main = false})
      : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: TextButton(
        onPressed: widget.onPressed,
        onHover: handleHover,
        style: TextButton.styleFrom(
          backgroundColor:
              isHover || widget.active ? (widget.main ? Colors.white : Color(0xff1d2428)) : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            widget.title,
            style: TextStyle(
              color: isHover || widget.active
                  ? (widget.main ? Color(0xff1d2428) : Colors.white)
                  : (widget.main ? Colors.white : Color(0xff1d2428)),
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
