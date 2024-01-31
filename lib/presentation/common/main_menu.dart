import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/presentation/common/menu_button.dart';

@immutable
class MainMenu extends StatelessWidget {
  final bool main;
  final String locale;

  const MainMenu({super.key, this.main = false, required this.locale});

  @override
  Widget build(BuildContext context) {
    final path = AutoRouter.of(context, watch: true).currentUrl;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MenuButton(
          main: main,
          onPressed: () => unawaited(context.router.replaceNamed("/")),
          title: S.current.menu_about,
          active: path == "/",
        ),
        MenuButton(
          main: main,
          onPressed: () => unawaited(context.router.replaceNamed("/skills")),
          title: S.current.menu_skills,
          active: path == "/skills",
        ),
        MenuButton(
          main: main,
          onPressed: () => unawaited(context.router.replaceNamed("/portfolio")),
          title: S.current.menu_portfolio,
          active: path == "/portfolio",
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
            onChanged: (val) => BlocProvider.of<LocaleBLoC>(context).add(LocaleEvent.change(val ?? 'en')),
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
