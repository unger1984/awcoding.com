import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';

@immutable
class PopupMenu extends StatelessWidget {
  const PopupMenu({Key? key}) : super(key: key);

  // Должен быть длинным
  // ignore: long-method
  List<PopupMenuEntry<dynamic>> menuBuilder(BuildContext context) {
    void handleChangeLocale(String? val) {
      BlocProvider.of<LocaleBLoC>(context).add(ChangeLocaleEvent(val ?? 'en'));
      Navigator.of(context).pop();
    }

    final go = GoRouter.of(context);

    return [
      PopupMenuItem(
        child: Text(
          S.of(context).menu_about,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: go.location == "/" ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
        onTap: () => context.goNamed("about"),
      ),
      PopupMenuItem(
        child: Text(
          S.of(context).menu_skills,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: go.location == "/skills" ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
        onTap: () => context.goNamed("skills"),
      ),
      PopupMenuItem(
        child: Text(
          S.of(context).menu_portfolio,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: go.location == "/portfolio" ? FontWeight.w700 : FontWeight.normal,
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
          onChanged: handleChangeLocale,
          decoration: const InputDecoration.collapsed(hintText: ''),
          style: const TextStyle(fontFamily: 'Montserrat', color: Colors.black),
          iconEnabledColor: Colors.black,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: menuBuilder,
    );
  }
}
