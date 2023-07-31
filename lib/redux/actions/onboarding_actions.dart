import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class SignupLoading {
  SignupLoading({
    required this.isLoading,
  }) {
    log.info('SignupLoading redux action -> [$isLoading]');
  }

  final bool isLoading;

  @override
  String toString() {
    return 'SignupLoading : isLoading:"$isLoading"';
  }
}

class SignUpLoadingMessage {
  SignUpLoadingMessage({
    required this.message,
  }) {
    log.info('SignUpLoadingMessage redux action -> [$message]');
  }

  final String message;

  @override
  String toString() {
    return 'SignUpLoadingMessage : message:"$message"';
  }
}

class SignUpFailed {
  SignUpFailed({
    required SignUpErrorDetails? error,
  }) {
    if (error != null && error.stackTrace == null) {
      error_ = SignUpErrorDetails(
        title: error.title,
        message: error.message,
        stackTrace: StackTraceFilter.fromStackLines(
          StackTrace.current.filterCallStack(
            dontMatch: RegExp('onboarding_actions'),
          ),
        ),
      );
    } else {
      error_ = error;
    }

    if (error_ != null) {
      log.warn('SignUpFailed redux action -> [$error_]');
    }
  }

  late final SignUpErrorDetails? error_;

  @override
  String toString() {
    return 'SignUpFailed : error:"$error_"';
  }
}

class SetConflictingFirebaseCredentials {
  SetConflictingFirebaseCredentials({
    required this.conflictingEmail,
    required this.conflictingCredentials,
  });

  final String conflictingEmail;
  final AuthCredential conflictingCredentials;

  @override
  String toString() {
    return 'SetConflictingFirebaseCredentials : conflictingEmail:"$conflictingEmail"';
  }
}
