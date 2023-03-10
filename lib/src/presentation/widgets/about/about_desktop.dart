import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/styles/styles.dart';
import 'package:portfolio/src/presentation/widgets/common/main_menu.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutClipperRight extends CustomClipper<Path> {
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

class AboutClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint = Offset(size.width - 115, 100);
    var endPoint = Offset(size.width - 50, 0);

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
class AboutDesktop extends StatelessWidget {
  final BuildContext context;
  const AboutDesktop({Key? key, required this.context}) : super(key: key);

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

        return SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: gradientRadial,
                ),
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
                                  onPressed: () => launchUrlString('mailto:unger1984@gmail.com'),
                                  icon: Icon(
                                    Icons.alternate_email_outlined,
                                    color: const Color(0xff1d2428),
                                    size: sizeIco,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => launchUrlString('https://github.com/unger1984'),
                                  icon: Image.asset(
                                    'assets/png/github.png',
                                    width: sizeIco,
                                    height: sizeIco,
                                    fit: BoxFit.contain,
                                    color: const Color(0xff1d2428),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => launchUrlString('https://twitter.com/unger1984'),
                                  icon: Image.asset(
                                    'assets/png/twitter.png',
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
                        clipper: AboutClipperRight(),
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
                    children: [
                      ClipPath(
                        clipper: AboutClipperBottom(),
                        child: Container(
                          color: const Color(0xff1d2428),
                          child: Padding(
                            padding: EdgeInsets.only(left: stextleft, right: 200, top: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  S.current.header_text,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: sizeText,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
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
      },
    );
  }
}
