import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/widgets/about/about_layout_desktop.dart';

@immutable
class AboutDesktop extends StatelessWidget {
  final BuildContext context;
  const AboutDesktop({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        final width = constrain.maxWidth;

        double sizeHi = 40;
        double sizeName = 80;
        double sizePosition = 25;
        double sizeText = 15;
        double sheight = 100;
        double stextleft = 100;
        double sizeIco = 64;
        if (width < 1122) {
          sizeHi = 20;
          sizeName = 40;
          sizePosition = 12.5;
          sizeIco = 64;
        }
        if (width < 750) {
          sizeText = 10;
          stextleft = 10;
          sizeIco = 32;
        }

        return AboutLayoutDesktop(
          sizeHi: sizeHi,
          sizeName: sizeName,
          sizePosition: sizePosition,
          sizeText: sizeText,
          sheight: sheight,
          stextleft: stextleft,
          sizeIco: sizeIco,
        );
      },
    );
  }
}
