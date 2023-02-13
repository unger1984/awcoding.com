import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';

@immutable
class PopupMenu extends StatelessWidget {
  const PopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(
            S.of(context).menu_about,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: GoRouter.of(context).location == "/" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("about"),
        ),
        PopupMenuItem(
          child: Text(
            S.of(context).menu_skills,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: GoRouter.of(context).location == "/skills" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("skills"),
        ),
        PopupMenuItem(
          child: Text(
            S.of(context).menu_portfolio,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: GoRouter.of(context).location == "/portfolio" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("portfolio"),
        ),
        PopupMenuItem(
          child: Text(
            S.of(context).menu_contact,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: GoRouter.of(context).location == "/contact" ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          onTap: () => context.goNamed("contact"),
        ),
        PopupMenuItem(
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
              Navigator.of(context).pop();
            },
            decoration: InputDecoration.collapsed(hintText: ''),
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
            // dropdownColor: Color(0xff1d2428),
            iconEnabledColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
