import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio/scr/presentation/widgets/header/header.dart';

@immutable
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Portfolio site',
      restorationScopeId: 'root',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(width: 1920),
            child: Container(
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  // color: Color(0xffC4C4C4),
                  ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Header(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
