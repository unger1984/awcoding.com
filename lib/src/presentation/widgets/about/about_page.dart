import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/widgets/about/about_desktop.dart';
import 'package:portfolio/src/presentation/widgets/about/about_mobile.dart';
import 'package:portfolio/src/utils/const.dart';

@immutable
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        if (constrain.maxWidth <= widthMobile) {
          return AboutMobile();
        }

        return AboutDesktop();
      },
    );
  }
}
