import 'package:flutter/material.dart';
import 'package:portfolio/presentation/common/popup_menu.dart';
import 'package:portfolio/utils/const.dart';

@immutable
class MainWrapper extends StatelessWidget {
  final Widget child;
  const MainWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return Scaffold(
          appBar: constrain.maxWidth <= Consts.widthMobile
              ? AppBar(
                  backgroundColor: const Color(0xff1d2428),
                  leading: const Icon(Icons.ac_unit, color: Colors.white),
                  actions: const [PopupMenu()],
                )
              : null,
          body: SizedBox(height: double.infinity, child: child),
        );
      },
    );
  }
}
