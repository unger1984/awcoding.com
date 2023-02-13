import 'package:l/l.dart';

abstract class AppLogger {
  void v(Object message);
  void d(Object message);
  void i(Object message);
  void w(Object message, [StackTrace? stackTrace]);
  void e(Object message, [StackTrace? stackTrace]);
}

class AppLoggerImpl extends AppLogger {
  @override
  void d(Object message) {
    l.d(message);
  }

  @override
  void e(Object message, [StackTrace? stackTrace]) {
    l.e(message, stackTrace);
  }

  @override
  void i(Object message) {
    l.i(message);
  }

  @override
  void v(Object message) {
    l.v(message);
  }

  @override
  void w(Object message, [StackTrace? stackTrace]) {
    l.w(message, stackTrace);
  }
}

final logger = AppLoggerImpl();
