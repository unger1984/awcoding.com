import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl_browser.dart';

sealed class LocaleEvent {
  const LocaleEvent();
  const factory LocaleEvent.init() = _InitLocaleEvent;
  const factory LocaleEvent.change(String locale) = _ChangeLocaleEvent;
}

class _InitLocaleEvent extends LocaleEvent {
  const _InitLocaleEvent();
}

class _ChangeLocaleEvent extends LocaleEvent {
  final String locale;
  const _ChangeLocaleEvent(this.locale);
}

sealed class LocaleState {
  const LocaleState();
  const factory LocaleState.loading() = LoadingLocaleState;
  const factory LocaleState.success(String locale) = SuccessLocaleState;
}

class LoadingLocaleState extends LocaleState {
  const LoadingLocaleState();
}

class SuccessLocaleState extends LocaleState {
  final String locale;
  const SuccessLocaleState(this.locale);
}

class LocaleBLoC extends Bloc<LocaleEvent, LocaleState> {
  LocaleBLoC() : super(const LocaleState.loading()) {
    on<LocaleEvent>(
      (event, emitter) => switch (event) {
        _InitLocaleEvent() => _init(emitter),
        _ChangeLocaleEvent() => _change(event, emitter),
      },
    );

    add(const LocaleEvent.init());
  }

  Future<void> _init(Emitter<LocaleState> emitter) async {
    emitter(const LocaleState.loading());
    final locale = await findSystemLocale();
    emitter(LocaleState.success(locale.characters.getRange(0, 2).toString()));
  }

  void _change(_ChangeLocaleEvent event, Emitter<LocaleState> emitter) {
    emitter(const LocaleState.loading());
    emitter(LocaleState.success(event.locale));
  }
}
