import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/src/utils/logger.dart';

@sealed
class AppBlocObserver extends BlocObserver {
  // ignore: avoid-global-state не ругайся плиз)
  static AppBlocObserver? _instance;

  factory AppBlocObserver.instance() => _instance ??= AppBlocObserver._();
  AppBlocObserver._();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('AppBlocObserver', stackTrace);
  }
}
