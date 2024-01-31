import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/domain/app_bloc_observer.dart';
import 'package:portfolio/presentation/app.dart';
import 'package:portfolio/utils/logging.dart';
import 'package:portfolio/utils/service_locator.dart';
import 'package:url_strategy/url_strategy.dart';

class Main {
  static final log = Logger('Main');

  static void setup() {
    // WidgetsFlutterBinding.ensureInitialized();
    Logging.setupLogging();
    setPathUrlStrategy();
    ServiceLocator.setup();
    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = bloc_concurrency.sequential<Object?>();
    runApp(const App());
  }
}

void main() {
  runZonedGuarded<void>(
    Main.setup,
    (err, stackTrace) => Main.log.shout('Unhandled exception', err, stackTrace),
  );
}
