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
  final String locale;

  const MainMenu({Key? key, this.main = false, required this.locale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final go = GoRouter.of(context);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("about"),
          title: S.current.menu_about,
          active: go.location == "/",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("skills"),
          title: S.current.menu_skills,
          active: go.location == "/skills",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("portfolio"),
          title: S.current.menu_portfolio,
          active: go.location == "/portfolio",
        ),
        SizedBox(
          width: 90,
          child: DropdownButtonFormField<String>(
            value: Intl.getCurrentLocale(),
            items: [
              DropdownMenuItem<String>(
                value: 'ru',
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/rus.png',
                      width: 32,
                      height: 32,
                    ),
                    const Text(' Rus'),
                  ],
                ),
              ),
              DropdownMenuItem<String>(
                value: 'en',
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/eng.png',
                      width: 32,
                      height: 32,
                    ),
                    const Text(' Eng'),
                  ],
                ),
              ),
            ],
            onChanged: (val) => BlocProvider.of<LocaleBLoC>(context).add(ChangeLocaleEvent(val ?? 'en')),
            decoration: const InputDecoration.collapsed(hintText: ''),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: main ? Colors.white : const Color(0xff1d2428),
            ),
            dropdownColor: main ? const Color(0xff1d2428) : Colors.white,
            iconEnabledColor: main ? Colors.white : const Color(0xff1d2428),
          ),
        ),
      ],
    );
  }
}
