import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/presentation/common/main_menu.dart';
import 'package:portfolio/presentation/common/main_wrapper.dart';
import 'package:portfolio/presentation/screens/skills/skill_item.dart';
import 'package:portfolio/utils/const.dart';

@immutable
@RoutePage()
class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: Container(
        decoration: const BoxDecoration(gradient: Consts.gradientRadial),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 800),
                child: LayoutBuilder(
                  builder: (context, constrain) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (constrain.maxWidth > Consts.widthMobile)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: MainMenu(locale: Intl.getCurrentLocale()),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Text(
                        S.current.skills_1,
                        style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      const Wrap(
                        children: [
                          SkillItem(title: 'HTML5', img: 'html'),
                          SkillItem(title: 'CSS3', img: 'css'),
                          SkillItem(title: 'JavaScript', img: 'js'),
                          SkillItem(title: 'TypeScript', img: 'ts'),
                          SkillItem(title: 'SASS', img: 'sass'),
                        ],
                      ),
                      Text(
                        S.current.skills_2,
                        style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      const Wrap(
                        children: [
                          SkillItem(title: 'Flutter', img: 'flutter'),
                          SkillItem(title: 'React Native', img: 'rn'),
                        ],
                      ),
                      Text(
                        S.current.skills_3,
                        style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      const Wrap(
                        children: [
                          SkillItem(title: 'NodeJS', img: 'node'),
                          SkillItem(title: 'TypeScript', img: 'ts'),
                          SkillItem(title: 'GoLang', img: 'go'),
                          SkillItem(title: 'PostgresSQL', img: 'postgres'),
                          SkillItem(title: 'MySQL', img: 'mysql'),
                          SkillItem(title: 'MongoDB', img: 'mongo'),
                          SkillItem(title: 'Dart', img: 'dart'),
                          SkillItem(title: 'Docker', img: 'docker'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
