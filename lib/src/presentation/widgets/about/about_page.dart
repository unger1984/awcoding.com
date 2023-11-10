import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/widgets/about/about_desktop.dart';
import 'package:portfolio/src/presentation/widgets/about/about_mobile.dart';
import 'package:portfolio/src/utils/const.dart';

@immutable
class AboutPage extends StatelessWidget {
  final BuildContext context;
  const AboutPage({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return (constrain.maxWidth <= Consts.widthMobile)
            ? AboutMobile(context: context)
            : AboutDesktop(context: context);
      },
    );
  }
}
