import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@lazySingleton
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
    if (sentry) {
      unawaited(
        Sentry.captureMessage(
          '$message',
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

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
    if (sentry) {
      unawaited(
        Sentry.captureMessage(
          '$message',
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

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
    if (sentry) {
      unawaited(
        Sentry.captureException(
          error ?? Exception('WARNING: $message'),
          stackTrace: stackTrace ?? StackTrace.current, // from catch (e, s)
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

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
    if (sentry) {
      unawaited(
        Sentry.captureException(
          error,
          stackTrace: stackTrace ?? StackTrace.current, // from catch (e, s)
          hint: sentryHint.isNotEmpty ? sentryHint : 'ERROR - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) {
      return;
    }

    logger.wtf(message, error, stackTrace);
  }
}
