import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portfolio/domain/entity/work_entity.dart';
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class PortfolioPopupMobile extends StatelessWidget {
  final WorkEntity work;

  const PortfolioPopupMobile({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    double sizeTitle = 18.0;
    double sizeText = 12;

    final linkGoogle = work.linkGoogle;
    final linkApple = work.linkApple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(height: MediaQuery.sizeOf(context).height / 3.5),
          child: Image.network(
            '/files/${work.img}',
            semanticLabel: work.img,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  work.title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: sizeTitle,
                  ),
                ),
                Text(
                  work.descriptions,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: sizeText,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    if (linkGoogle != null)
                      TextButton(
                        onPressed: () => unawaited(launchUrlString(linkGoogle)),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/png/playmarket.png',
                              semanticLabel: 'playmarket',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Google Play Market',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    if (linkApple != null)
                      TextButton(
                        onPressed: () => unawaited(launchUrlString(linkApple)),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/png/appstore.png',
                              semanticLabel: 'appstore',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Apple Store',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
