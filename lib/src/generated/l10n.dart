// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Andrey Unger site`
  String get title {
    return Intl.message(
      'Andrey Unger site',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Hi, I am`
  String get header_hi {
    return Intl.message(
      'Hi, I am',
      name: 'header_hi',
      desc: '',
      args: [],
    );
  }

  /// `Andrey Unger`
  String get header_name {
    return Intl.message(
      'Andrey Unger',
      name: 'header_name',
      desc: '',
      args: [],
    );
  }

  /// `Full-stack developer`
  String get header_position {
    return Intl.message(
      'Full-stack developer',
      name: 'header_position',
      desc: '',
      args: [],
    );
  }

  /// `Software development since 2003`
  String get header_text {
    return Intl.message(
      'Software development since 2003',
      name: 'header_text',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get menu_about {
    return Intl.message(
      'About me',
      name: 'menu_about',
      desc: '',
      args: [],
    );
  }

  /// `Skills`
  String get menu_skills {
    return Intl.message(
      'Skills',
      name: 'menu_skills',
      desc: '',
      args: [],
    );
  }

  /// `Portfolio`
  String get menu_portfolio {
    return Intl.message(
      'Portfolio',
      name: 'menu_portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Frontend Web:`
  String get skills_1 {
    return Intl.message(
      'Frontend Web:',
      name: 'skills_1',
      desc: '',
      args: [],
    );
  }

  /// `Frontend Mobile:`
  String get skills_2 {
    return Intl.message(
      'Frontend Mobile:',
      name: 'skills_2',
      desc: '',
      args: [],
    );
  }

  /// `Backend:`
  String get skills_3 {
    return Intl.message(
      'Backend:',
      name: 'skills_3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
