import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  final Logger _info = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  final Logger _debug = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  final Logger _warning = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  final Logger _error = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  void log(String message) {
    if (kDebugMode) _info.i('{"type": "log", "message": "$message"}');
  }

  void debug(String message) {
    if (kDebugMode) _debug.d('{"type": "debug", "message": "$message"}');
  }

  void warning(String message) {
    if (kDebugMode) _warning.w('{"type": "warning", "message": "$message"}');
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _error.e('{"type": "error", "message": "$message"}', error: error, stackTrace: stackTrace);
    }
  }
}

final appLogger = AppLogger();
