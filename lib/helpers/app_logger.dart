import 'package:logger/logger.dart';

/// A utility class for logging messages in a structured and customizable way.
///
/// This logger uses the `Logger` package and a `PrettyPrinter` to format logs
/// with features like method count, colorful output, emojis, and more.
///
/// ### Developer
/// - **Name:** Md. Shamsuzzaman
/// - **GitHub:** [zamansheikh](https://github.com/zamansheikh)
///
/// ### Usage
/// Use the static methods (`d`, `i`, `w`, `e`, `f`) to log messages directly.
/// Or use the `Loggable` extension to log messages from any object.
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Ensures the message is safely converted to a string for logging.
  static String _safeToString(dynamic message) {
    try {
      return message?.toString() ?? 'null';
    } catch (e) {
      return 'Error converting message to string: $e';
    }
  }

  /// Logs a debug message.
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(_safeToString(message), error: error, stackTrace: stackTrace);
  }

  /// Logs an informational message.
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(_safeToString(message), error: error, stackTrace: stackTrace);
  }

  /// Logs a warning message.
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(_safeToString(message), error: error, stackTrace: stackTrace);
  }

  /// Logs an error message.
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(_safeToString(message), error: error, stackTrace: stackTrace);
  }

  /// Logs a fatal error message.
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(_safeToString(message), error: stackTrace);
  }
}

/// Extension for easier logging on objects.
///
/// This extension adds logging methods (`logD`, `logI`, `logW`, `logE`, `logF`)
/// to any object, making it convenient to log directly from any instance.
///
/// ### Example
/// ```dart
/// "A debug message".logD();
/// 123.logI();
/// {"key": "value"}.logW();
/// ```
extension Loggable on Object {
  /// Ensures the current object is safely converted to a string for logging.
  String _safeToString() {
    try {
      return toString();
    } catch (e) {
      return 'Error converting object to string: $e';
    }
  }

  void logD([dynamic error, StackTrace? stackTrace]) {
    AppLogger.d(_safeToString(), error, stackTrace);
  }

  void logI([dynamic error, StackTrace? stackTrace]) {
    AppLogger.i(_safeToString(), error, stackTrace);
  }

  void logW([dynamic error, StackTrace? stackTrace]) {
    AppLogger.w(_safeToString(), error, stackTrace);
  }

  void logE([dynamic error, StackTrace? stackTrace]) {
    AppLogger.e(_safeToString(), error, stackTrace);
  }

  void logF([dynamic error, StackTrace? stackTrace]) {
    AppLogger.f(_safeToString(), error, stackTrace);
  }
}
