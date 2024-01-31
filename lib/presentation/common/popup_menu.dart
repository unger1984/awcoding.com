import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/presentation/blocs/locale_bloc.dart';

@immutable
class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  void _handleChangeLocale(String? val) {
    BlocProvider.of<LocaleBLoC>(context).add(LocaleEvent.change(val ?? 'en'));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final path = AutoRouter.of(context, watch: true).currentUrl;

    return PopupMenuButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem<void>(
          child: Text(
            S.of(context).menu_about,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: path == "/" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => unawaited(context.router.replaceNamed("/")),
        ),
        PopupMenuItem<void>(
          child: Text(
            S.of(context).menu_skills,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: path == "/skills" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => unawaited(context.router.replaceNamed("/skills")),
        ),
        PopupMenuItem<void>(
          child: Text(
            S.of(context).menu_portfolio,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: path == "/portfolio" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => unawaited(context.router.replaceNamed("/portfolio")),
        ),
        PopupMenuItem<void>(
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
            onChanged: _handleChangeLocale,
            decoration: const InputDecoration.collapsed(hintText: ''),
            style: const TextStyle(fontFamily: 'Montserrat', color: Colors.black),
            iconEnabledColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
