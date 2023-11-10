import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/src/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/routes/app_router.dart';

@immutable
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _localeBLoC = LocaleBLoC();
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    unawaited(SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]));
    // findSystemLocale().then((value) => localeBLoC.add(ChangeLocaleEvent(value.substring(0, 2))));
  }

  @override
  dispose() {
    unawaited(SystemChrome.setPreferredOrientations(DeviceOrientation.values));
    unawaited(_localeBLoC.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBLoC>.value(
      value: _localeBLoC,
      child: BlocBuilder<LocaleBLoC, LocaleState>(
        builder: (context, state) => state.map(
          loading: (_) => Container(),
          success: (st) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale.fromSubtags(languageCode: st.locale),
              supportedLocales: S.delegate.supportedLocales,
              onGenerateTitle: (context) => S.of(context).title,
              restorationScopeId: 'root',
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.blueGrey,
                scaffoldBackgroundColor: Colors.white,
              ),
              routerConfig: _appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
