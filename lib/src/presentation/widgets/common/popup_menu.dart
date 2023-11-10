import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/src/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/routes/app_router.dart';

@immutable
class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  void _handleChangeLocale(String? val) {
    BlocProvider.of<LocaleBLoC>(context).add(ChangeLocaleEvent(val ?? 'en'));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final location = AppRouter.ofLocation(context);

    return PopupMenuButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(
            S.of(context).menu_about,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: location == "/" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("about"),
        ),
        PopupMenuItem(
          child: Text(
            S.of(context).menu_skills,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: location == "/skills" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("skills"),
        ),
        PopupMenuItem(
          child: Text(
            S.of(context).menu_portfolio,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: location == "/portfolio" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("portfolio"),
        ),
        PopupMenuItem(
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
