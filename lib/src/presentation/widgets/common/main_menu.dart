import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/widgets/common/menu_button.dart';

@immutable
class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, top: 65, bottom: 20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MenuButton(
            onPressed: () => context.goNamed("about"),
            title: S.current.menu_about,
            active: GoRouter.of(context).location == "/",
          ),
          MenuButton(
            onPressed: () => context.goNamed("skills"),
            title: S.current.menu_skills,
            active: GoRouter.of(context).location == "/skills",
          ),
          MenuButton(
            onPressed: () => context.goNamed("portfolio"),
            title: S.current.menu_portfolio,
            active: GoRouter.of(context).location == "/portfolio",
          ),
          MenuButton(
            onPressed: () => context.goNamed("contact"),
            title: S.current.menu_contact,
            active: GoRouter.of(context).location == "/contact",
          ),
          SizedBox(
            width: 90,
            child: DropdownButtonFormField<String>(
              value: Intl.getCurrentLocale(),
              items: [
                DropdownMenuItem<String>(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/png/rus.png',
                        width: 32,
                        height: 32,
                      ),
                      Text(' Rus'),
                    ],
                  ),
                  value: 'ru',
                ),
                DropdownMenuItem<String>(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/png/eng.png',
                        width: 32,
                        height: 32,
                      ),
                      Text(' Eng'),
                    ],
                  ),
                  value: 'en',
                ),
              ],
              onChanged: (val) {
                BlocProvider.of<LocaleBLoC>(context).add(ChangeLocaleEvent(val ?? 'en'));
              },
              decoration: InputDecoration.collapsed(hintText: ''),
              style: TextStyle(color: Colors.white),
              dropdownColor: Color(0xff1d2428),
              iconEnabledColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
