import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/src/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/routes/app_router.dart';
import 'package:portfolio/src/presentation/widgets/common/menu_button.dart';

@immutable
class MainMenu extends StatelessWidget {
  final bool main;
  final String locale;

  const MainMenu({super.key, this.main = false, required this.locale});

  @override
  Widget build(BuildContext context) {
    final location = AppRouter.ofLocation(context);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("about"),
          title: S.current.menu_about,
          active: location == "/",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("skills"),
          title: S.current.menu_skills,
          active: location == "/skills",
        ),
        MenuButton(
          main: main,
          onPressed: () => context.goNamed("portfolio"),
          title: S.current.menu_portfolio,
          active: location == "/portfolio",
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
                      semanticLabel: 'rus',
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
                      semanticLabel: 'eng',
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
