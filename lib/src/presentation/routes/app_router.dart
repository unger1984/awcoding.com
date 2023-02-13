import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/presentation/widgets/about/about_page.dart';
import 'package:portfolio/src/presentation/widgets/common/popup_menu.dart';
import 'package:portfolio/src/presentation/widgets/skills/skills_page.dart';
import 'package:portfolio/src/utils/const.dart';

class PageFade<T> extends Page<T> {
  final Widget child;

  const PageFade({required this.child, LocalKey? key, String? name}) : super(key: key, name: name);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _mainNavigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey2 = GlobalKey<NavigatorState>();

  static Page<T> transitionsFade<T>(GoRouterState state, Widget child) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 550),
      transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeIn;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return FadeTransition(
          opacity: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static Page<T> transitionsSlide<T>(GoRouterState state, Widget child) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) => LayoutBuilder(
          builder: (context, constrain) {
            return Scaffold(
              appBar: constrain.maxWidth <= widthMobile
                  ? AppBar(
                      backgroundColor: Color(0xff1d2428),
                      leading: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                      actions: [
                        PopupMenu(),
                      ],
                    )
                  : null,
              body: child,
            );
          },
        ),
        routes: [
          GoRoute(
            path: "/",
            name: "about",
            pageBuilder: (context, state) => transitionsFade(state, AboutPage()),
          ),
          GoRoute(
            path: "/skills",
            name: "skills",
            pageBuilder: (context, state) => transitionsFade(state, SkillsPage()),
          ),
          GoRoute(
            path: "/portfolio",
            name: "portfolio",
            pageBuilder: (context, state) => transitionsFade(state, AboutPage()),
          ),
          GoRoute(
            path: "/contact",
            name: "contact",
            pageBuilder: (context, state) => transitionsFade(state, AboutPage()),
          ),
        ],
      ),
      // GoRoute(
      //   path: "/2",
      //   name: "second",
      //   // builder: (_, __) => const PageSecond(),
      //   pageBuilder: (context, state) => transitionsFade(state, PageSecond()),
      // ),
    ],
  );
}
