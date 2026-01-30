import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$tagStr$message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
    // Future: Integrate with external logging service (e.g., Crashlytics, Sentry)
  }

  static void info(String message, [String? tag]) =>
      log('INFO: $message', tag: tag);
  static void warning(String message, [String? tag]) =>
      log('WARN: $message', tag: tag);
  static void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) => log('ERROR: $message', tag: tag, error: error, stackTrace: stackTrace);
}
