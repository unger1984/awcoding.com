import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/src/app.dart';
import 'package:portfolio/src/domain/app_bloc_observer.dart';
import 'package:portfolio/src/utils/di.dart';
import 'package:portfolio/src/utils/log.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  final log = Logger('Main');
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging();
  setPathUrlStrategy();
  setupGetIt();

  runZonedGuarded<void>(
    () {
      Bloc.observer = AppBlocObserver.instance();
      Bloc.transformer = bloc_concurrency.sequential<Object?>();
      runApp(const App());
    },
    (err, stackTrace) => log.shout('Unhandled exception', err, stackTrace),
  );
}
