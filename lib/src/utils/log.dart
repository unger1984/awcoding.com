// ignore_for_file: prefer-static-class

import 'package:colorize/colorize.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

void multiline(Object? obj, Styles style, {String? startText, String? endText}) {
  if (obj == null) return;
  if (startText != null) color('\t\t$startText', front: style);
  final lines = (obj.toString().split('\n')).where((line) => line.trim().isNotEmpty);
  for (final line in lines) {
    color('\t\t$line', front: style);
  }
  if (endText != null) color('\t\t$endText', front: style);
}

void setupLogging() {
  Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;

  // Это диспозится при вызходи из прилы
  // ignore: avoid-unassigned-stream-subscriptions
  Logger.root.onRecord.listen((record) {
    Styles front = Styles.BLACK;
    switch (record.level.toString()) {
      case 'SHOUT':
      case 'SEVERE':
        front = Styles.RED;
        break;
      case 'FINEST':
      case 'FINER':
      case 'FINE':
        front = Styles.GREEN;
        break;
      case 'CONFIG':
      case 'INFO':
        front = Styles.BLUE;
        break;
      case 'WARNING':
        front = Styles.YELLOW;
        break;
    }
    final num = Colorize('[${NumberFormat().format(record.sequenceNumber)}]')
      ..bold()
      ..apply(front);
    final time = Colorize(DateFormat('HH:mm:ss').format(record.time))
      ..bold()
      ..apply(front);
    final name = Colorize(record.loggerName)
      ..underline()
      ..bold()
      ..apply(front);
    final message = Colorize(record.message)..apply(front);
    color('$num $time $name $message');
    multiline(record.error, front);
    multiline(record.stackTrace, front, startText: '=== STACK ===');
  });
}
