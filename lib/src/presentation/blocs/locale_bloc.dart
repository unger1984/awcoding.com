import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl_browser.dart';

part 'locale_bloc.freezed.dart';

@freezed
class LocaleEvent with _$LocaleEvent {
  const LocaleEvent._();
  const factory LocaleEvent.init() = InitLocaleEvent;
  const factory LocaleEvent.change(String locale) = ChangeLocaleEvent;
}

@freezed
class LocaleState with _$LocaleState {
  const LocaleState._();
  const factory LocaleState.loading() = LoadingLocaleState;
  const factory LocaleState.success(String locale) = SuccessLocaleState;
}

class LocaleBLoC extends Bloc<LocaleEvent, LocaleState> {
  LocaleBLoC() : super(const LoadingLocaleState()) {
    on<LocaleEvent>(
      (event, emitter) => event.map(
        init: (event) async => await _init(emitter),
        change: (event) => _change(event, emitter),
      ),
    );

    add(const InitLocaleEvent());
  }

  Future<void> _init(Emitter<LocaleState> emitter) async {
    emitter(const LoadingLocaleState());
    final locale = await findSystemLocale();
    emitter(SuccessLocaleState(locale.characters.getRange(0, 2).toString()));
  }

  void _change(ChangeLocaleEvent event, Emitter<LocaleState> emitter) {
    emitter(SuccessLocaleState(event.locale));
  }
}
