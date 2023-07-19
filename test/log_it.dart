import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogIt {
  LogIt(this.logger);

  final Logger logger;

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) {
      return;
    }

    logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = false,
    String sentryHint = '',
  }) {
    logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = false,
    String sentryHint = '',
  }) {
    logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = true,
    String sentryHint = '',
  }) {
    logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = true,
    String sentryHint = '',
  }) {
    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logger.wtf(message, error, stackTrace);
  }
}
