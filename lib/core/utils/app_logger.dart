import 'package:flutter/foundation.dart';

/// Minimal logging seam. Kept tiny on purpose; in a production app this would
/// wrap a structured logger. Comments/logs explain *why*, not *what*.
class AppLogger {
  const AppLogger();

  void info(String message) => _log('INFO', message);
  void warn(String message) => _log('WARN', message);
  void error(String message, [Object? error, StackTrace? stack]) =>
      _log('ERROR', '$message${error != null ? ' | $error' : ''}');

  void _log(String level, String message) {
    if (kDebugMode) {
      debugPrint('[$level] $message');
    }
  }
}
