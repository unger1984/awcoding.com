import 'package:flutter/material.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addPolygon(
        [
          Offset(0, size.height),
          Offset(0, size.height - size.height + 100),
          Offset(size.width, 0),
          Offset(size.width, size.height),
        ],
        true,
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

@immutable
class AboutMobile extends StatelessWidget {
  final BuildContext context;

  const AboutMobile({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 220.0),
              child: Image.asset(
                'assets/png/I3.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 300,
              child: ClipPath(
                clipper: AboutClipperRight(),
                child: Container(
                  color: const Color(0xff1d2428),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            S.current.header_hi,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            S.current.header_name,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            S.current.header_position,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                      // SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () => launchUrlString('mailto:unger1984@gmail.com'),
                              icon: const Icon(
                                Icons.alternate_email_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 10),
                            IconButton(
                              onPressed: () => launchUrlString('https://github.com/unger1984'),
                              icon: Image.asset(
                                'assets/png/github.png',
                                width: 32,
                                height: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            IconButton(
                              onPressed: () => launchUrlString('https://twitter.com/unger1984'),
                              icon: Image.asset(
                                'assets/png/twitter.png',
                                width: 32,
                                height: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
