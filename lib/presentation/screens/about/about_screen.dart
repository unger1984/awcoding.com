import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/presentation/common/main_wrapper.dart';
import 'package:portfolio/presentation/screens/about/about_desktop.dart';
import 'package:portfolio/presentation/screens/about/about_mobile.dart';
import 'package:portfolio/utils/const.dart';

@immutable
@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: LayoutBuilder(
        builder: (context, constrain) {
          return (constrain.maxWidth <= Consts.widthMobile)
              ? AboutMobile(context: context)
              : AboutDesktop(context: context);
        },
      ),
    );
  }
}
