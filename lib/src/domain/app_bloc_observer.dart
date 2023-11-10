import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

@sealed
class AppBlocObserver extends BlocObserver {
  static final _log = Logger('AppBlocObserver');
  // ignore: avoid-global-state не ругайся плиз)
  static AppBlocObserver? _instance;

  factory AppBlocObserver.instance() => _instance ??= const AppBlocObserver._();
  const AppBlocObserver._();

  @override
  // ХЗ что тут за блок будет
  // ignore: avoid-dynamic
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log.shout('Unhandled BLoC error', stackTrace);
  }
}
