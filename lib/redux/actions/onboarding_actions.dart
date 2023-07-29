import 'package:firebase_auth/firebase_auth.dart';
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
    required this.error,
  }) {
    if (error != null) {
      log.warn('SignUpFailed redux action -> [$error]');
    }
  }

  final SignUpErrorDetails? error;

  @override
  String toString() {
    return 'SignUpFailed : error:"$error"';
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
