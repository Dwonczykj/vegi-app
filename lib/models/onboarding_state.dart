import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';

part 'onboarding_state.freezed.dart';
part 'onboarding_state.g.dart';

List<OnboardingState> fromJsonOnboardingStateList(dynamic json) =>
    fromSailsListOfObjectJson<OnboardingState>(OnboardingState.fromJson)(json);
OnboardingState? fromJsonOnboardingState(dynamic json) =>
    fromSailsObjectJson<OnboardingState>(OnboardingState.fromJson)(json);

@Freezed()
class OnboardingState with _$OnboardingState {
  @JsonSerializable()
  factory OnboardingState({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool signupIsInFlux,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(null)
    SignUpErrorDetails? signupError,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String signupStatusMessage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    AuthCredential? conflictingCredentials,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? conflictingEmail,
  }) = _OnboardingState;

  const OnboardingState._();

  factory OnboardingState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$OnboardingStateFromJson(json),
      );

  factory OnboardingState.initial() => OnboardingState();
}

class OnboardingStateConverter
    implements JsonConverter<OnboardingState, Map<String, dynamic>?> {
  const OnboardingStateConverter();

  @override
  OnboardingState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null
            ? OnboardingState.fromJson(json)
            : OnboardingState.initial(),
      );

  @override
  Map<String, dynamic> toJson(OnboardingState instance) => instance.toJson();
}
