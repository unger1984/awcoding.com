import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool active;
  final bool main;

  const MenuButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.active = false,
    this.main = false,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isHover = false;

  void _handleHover(bool hover) {
    setState(() {
      _isHover = hover;
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
        onHover: _handleHover,
        style: TextButton.styleFrom(
          backgroundColor: _isHover || widget.active ? bgColor : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            widget.title,
            style: TextStyle(
              color: _isHover || widget.active ? fontColor : bgColor,
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
