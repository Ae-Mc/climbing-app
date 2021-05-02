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

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `Climb`
  String get Climb {
    return Intl.message(
      'Climb',
      name: 'Climb',
      desc: '',
      args: [],
    );
  }

  /// `Climb date`
  String get ClimbDate {
    return Intl.message(
      'Climb date',
      name: 'ClimbDate',
      desc: '',
      args: [],
    );
  }

  /// `Climb time`
  String get ClimbTime {
    return Intl.message(
      'Climb time',
      name: 'ClimbTime',
      desc: '',
      args: [],
    );
  }

  /// `First`
  String get First {
    return Intl.message(
      'First',
      name: 'First',
      desc: '',
      args: [],
    );
  }

  /// `First lap`
  String get FirstLap {
    return Intl.message(
      'First lap',
      name: 'FirstLap',
      desc: '',
      args: [],
    );
  }

  /// `Guide`
  String get Guide {
    return Intl.message(
      'Guide',
      name: 'Guide',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get History {
    return Intl.message(
      'History',
      name: 'History',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `ITMO Climbing`
  String get ITMOClimbing {
    return Intl.message(
      'ITMO Climbing',
      name: 'ITMOClimbing',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get Export {
    return Intl.message(
      'Export',
      name: 'Export',
      desc: '',
      args: [],
    );
  }

  /// `Lap`
  String get Lap {
    return Intl.message(
      'Lap',
      name: 'Lap',
      desc: '',
      args: [],
    );
  }

  /// `Lap time`
  String get LapTime {
    return Intl.message(
      'Lap time',
      name: 'LapTime',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get Left {
    return Intl.message(
      'Left',
      name: 'Left',
      desc: '',
      args: [],
    );
  }

  /// `Marks`
  String get Marks {
    return Intl.message(
      'Marks',
      name: 'Marks',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get Right {
    return Intl.message(
      'Right',
      name: 'Right',
      desc: '',
      args: [],
    );
  }

  /// `Total time`
  String get TotalTime {
    return Intl.message(
      'Total time',
      name: 'TotalTime',
      desc: '',
      args: [],
    );
  }

  /// `Second`
  String get Second {
    return Intl.message(
      'Second',
      name: 'Second',
      desc: '',
      args: [],
    );
  }

  /// `Second lap`
  String get SecondLap {
    return Intl.message(
      'Second lap',
      name: 'SecondLap',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Third`
  String get Third {
    return Intl.message(
      'Third',
      name: 'Third',
      desc: '',
      args: [],
    );
  }

  /// `Third lap`
  String get ThirdLap {
    return Intl.message(
      'Third lap',
      name: 'ThirdLap',
      desc: '',
      args: [],
    );
  }

  /// `Traverse`
  String get Traverse {
    return Intl.message(
      'Traverse',
      name: 'Traverse',
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
