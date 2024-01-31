import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/presentation/widgets/about/about_page.dart';
import 'package:portfolio/src/presentation/widgets/common/popup_menu.dart';
import 'package:portfolio/src/presentation/widgets/portfolio/portfolio_page.dart';
import 'package:portfolio/src/presentation/widgets/skills/skills_page.dart';
import 'package:portfolio/src/utils/const.dart';

class PageFade<T> extends Page<T> {
  final Widget child;

  const PageFade({required this.child, super.key, super.name});

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // Тут это точно нужно.
  // ignore: avoid-late-keyword
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          builder: (context, state, child) => LayoutBuilder(
            builder: (context, constrain) {
              return Scaffold(
                appBar: constrain.maxWidth <= Consts.widthMobile
                    ? AppBar(
                        backgroundColor: const Color(0xff1d2428),
                        leading: const Icon(
                          Icons.ac_unit,
                          color: Colors.white,
                        ),
                        actions: const [PopupMenu()],
                      )
                    : null,
                body: Builder(builder: (context) => child),
              );
            },
          ),
          routes: [
            GoRoute(
              path: "/",
              name: "about",
              pageBuilder: (context, state) => _handleTransitionsFadeBuilder(state, AboutPage(context: context)),
            ),
            GoRoute(
              path: "/skills",
              name: "skills",
              pageBuilder: (context, state) => _handleTransitionsFadeBuilder(state, SkillsPage(context: context)),
            ),
            GoRoute(
              path: "/portfolio",
              name: "portfolio",
              pageBuilder: (context, state) => _handleTransitionsFadeBuilder(state, PortfolioPage(context: context)),
            ),
          ],
        ),
      ],
    );
  }

  String get location {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;

    return matchList.uri.toString();
  }

  static String ofLocation(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final lastMatch = goRouter.routerDelegate.currentConfiguration.last;
    final matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : goRouter.routerDelegate.currentConfiguration;

    return matchList.uri.toString();
  }

  static Page<T> _handleTransitionsFadeBuilder<T>(GoRouterState state, Widget child) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 550),
      transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget chld) {
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
          child: chld,
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
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget chld) {
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
          child: chld,
        );
      },
    );
  }
}
