import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/app.dart';
import 'package:portfolio/src/domain/app_bloc_observer.dart';
import 'package:portfolio/src/utils/logger.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> setupGetIt() async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await setupGetIt();

  runZonedGuarded<void>(
    () {
      Bloc.observer = AppBlocObserver.instance();
      Bloc.transformer = bloc_concurrency.sequential<Object?>();
      runApp(const App());
    },
    (err, stackTrace) => logger.e(err, stackTrace),
  );
}
