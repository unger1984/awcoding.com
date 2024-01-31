import 'package:auto_route/auto_route.dart';
import 'package:portfolio/presentation/screens/about/about_screen.dart';
import 'package:portfolio/presentation/screens/portfolio/portfolio_screen.dart';
import 'package:portfolio/presentation/screens/skills/skills_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Router,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AboutRoute.page, initial: true, path: '/'),
        AutoRoute(page: SkillsRoute.page, path: '/skills'),
        AutoRoute(page: PortfolioRoute.page, path: '/portfolio'),
      ];
}
