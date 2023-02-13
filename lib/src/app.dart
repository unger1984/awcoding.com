import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/src/presentation/blocs/locale_bloc.dart';
import 'package:portfolio/src/presentation/routes/app_router.dart';

@immutable
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final localeBLoC = LocaleBLoC();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // findSystemLocale().then((value) => localeBLoC.add(ChangeLocaleEvent(value.substring(0, 2))));
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    localeBLoC.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBLoC>.value(
      value: localeBLoC,
      child: BlocBuilder<LocaleBLoC, LocaleState>(
        builder: (context, state) => state.map(
          loading: (_) => Container(),
          success: (st) => MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale.fromSubtags(languageCode: st.locale),
            supportedLocales: S.delegate.supportedLocales,
            title: 'Portfolio site',
            restorationScopeId: 'root',
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.white,
            ),
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}
