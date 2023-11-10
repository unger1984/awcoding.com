import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/src/generated/l10n.dart';
import 'package:portfolio/src/presentation/widgets/common/main_menu.dart';
import 'package:portfolio/src/utils/const.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutDesktopClipperRight extends CustomClipper<Path> {
  const AboutDesktopClipperRight();

  @override
  Path getClip(Size size) {
    return Path()
      ..addPolygon(
        [const Offset(50, 0), Offset(size.width, 0), Offset(size.width, size.height), Offset(0, size.height)],
        true,
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AboutDesktopClipperBottom extends CustomClipper<Path> {
  const AboutDesktopClipperBottom();

  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width - 115, 100);
    Offset endPoint = Offset(size.width - 50, 0);

    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 190, 0)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

@immutable
class AboutLayoutDesktop extends StatelessWidget {
  final double sizeHi;
  final double sizeName;
  final double sizePosition;
  final double sizeText;
  final double sheight;
  final double stextleft;
  final double sizeIco;

  const AboutLayoutDesktop({
    super.key,
    required this.sizeHi,
    required this.sizeName,
    required this.sizePosition,
    required this.sizeText,
    required this.sheight,
    required this.stextleft,
    required this.sizeIco,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(gradient: Consts.gradientRadial),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20, top: 20, bottom: sheight),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.ac_unit, size: 60),
                        const Expanded(child: SizedBox()),
                        Text(
                          S.current.header_hi,
                          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: sizeHi),
                        ),
                        Text(
                          S.current.header_name,
                          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, fontSize: sizeName),
                        ),
                        Text(
                          S.current.header_position,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: const Color(0xff909090),
                            fontWeight: FontWeight.w800,
                            fontSize: sizePosition,
                          ),
                        ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => unawaited(launchUrlString('mailto:unger1984@gmail.com')),
                              icon: Icon(
                                Icons.alternate_email_outlined,
                                color: const Color(0xff1d2428),
                                size: sizeIco,
                              ),
                            ),
                            IconButton(
                              onPressed: () => unawaited(launchUrlString('https://github.com/unger1984')),
                              icon: Image.asset(
                                'assets/png/github.png',
                                semanticLabel: 'github',
                                width: sizeIco,
                                height: sizeIco,
                                fit: BoxFit.contain,
                                color: const Color(0xff1d2428),
                              ),
                            ),
                            IconButton(
                              onPressed: () => unawaited(launchUrlString('https://twitter.com/unger1984')),
                              icon: Image.asset(
                                'assets/png/twitter.png',
                                semanticLabel: 'twitter',
                                width: sizeIco,
                                height: sizeIco,
                                color: const Color(0xff1d2428),
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ClipPath(
                    clipper: const AboutDesktopClipperRight(),
                    child: Container(
                      color: Colors.blueGrey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 80.0, top: 65, bottom: 20),
                            child: MainMenu(main: true, locale: Intl.getCurrentLocale()),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: sheight / 2),
                                child: Image.asset(
                                  'assets/png/I3.png',
                                  semanticLabel: 'Andrey Unger',
                                  scale: 0.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: sheight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipPath(
                    clipper: const AboutDesktopClipperBottom(),
                    child: Container(
                      color: const Color(0xff1d2428),
                      child: Padding(
                        padding: EdgeInsets.only(left: stextleft, right: 200, top: 40),
                        child: Text(
                          S.current.header_text,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: sizeText,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Image.asset(
                        'assets/png/IT.png',
                        semanticLabel: 'IT',
                        // color: Colors.black,
                        scale: 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
