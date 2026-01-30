import '../logging/app_logger.dart';

class AppError {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppError(this.message, {this.originalError, this.stackTrace});

  @override
  String toString() => 'AppError: $message';
}

class ErrorReporter {
  static void report(
    dynamic error,
    StackTrace? stackTrace, {
    String context = 'Unknown',
  }) {
    // Log to console locally
    AppLogger.error(
      'Exception caught in $context',
      error: error,
      stackTrace: stackTrace,
    );

    // Future: Send to remote crash reporting (e.g., Sentry, Firebase Crashlytics)
    // _sendToRemoteService(error, stackTrace);
  }
}
