import 'package:flutter/material.dart';
import 'package:portfolio/src/domain/entity/work_entity.dart';

@immutable
class PortfolioPopupDesktop extends StatelessWidget {
  final WorkEntity work;

  const PortfolioPopupDesktop({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        double sizeTitle = 30.0;
        double sizeText = 18;
        if (MediaQuery.of(context).size.width < 800) {
          sizeTitle = 18;
          sizeText = 12;
        }

        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width / 2),
                child: Image.network(
                  '/files/${work.img}',
                  fit: BoxFit.fitHeight,
                ),
              ),
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
                      Expanded(child: SizedBox()),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/png/playmarket.png',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Google Play Market',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/png/appstore.png',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 10),
                                Text(
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
          ),
        );
      },
    );
  }
}