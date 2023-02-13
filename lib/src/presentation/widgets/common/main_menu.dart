import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/widgets/common/menu_button.dart';

@immutable
class MainMenu extends StatelessWidget {
  final bool main;
  const MainMenu({Key? key, this.main = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("about"),
          title: S.current.menu_about,
          active: GoRouter.of(context).location == "/",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("skills"),
          title: S.current.menu_skills,
          active: GoRouter.of(context).location == "/skills",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("portfolio"),
          title: S.current.menu_portfolio,
          active: GoRouter.of(context).location == "/portfolio",
        ),
        MenuButton(
          main: main,
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
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: main ? Colors.white : Color(0xff1d2428),
            ),
            dropdownColor: main ? Color(0xff1d2428) : Colors.white,
            iconEnabledColor: main ? Colors.white : Color(0xff1d2428),
          ),
        ),
      ],
    );
  }
}
