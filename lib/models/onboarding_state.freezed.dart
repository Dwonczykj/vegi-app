// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OnboardingState _$OnboardingStateFromJson(Map<String, dynamic> json) {
  return _OnboardingState.fromJson(json);
}

/// @nodoc
mixin _$OnboardingState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get signupIsInFlux => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  SignUpErrorDetails? get signupError => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get signupStatusMessage => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  AuthCredential? get conflictingCredentials =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get conflictingEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
          bool signupIsInFlux,
      @JsonKey(includeFromJson: false, includeToJson: false)
          SignUpErrorDetails? signupError,
      @JsonKey(includeFromJson: false, includeToJson: false)
          String signupStatusMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
          AuthCredential? conflictingCredentials,
      @JsonKey(includeFromJson: false, includeToJson: false)
          String? conflictingEmail});

  $SignUpErrorDetailsCopyWith<$Res>? get signupError;
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signupIsInFlux = null,
    Object? signupError = freezed,
    Object? signupStatusMessage = null,
    Object? conflictingCredentials = freezed,
    Object? conflictingEmail = freezed,
  }) {
    return _then(_value.copyWith(
      signupIsInFlux: null == signupIsInFlux
          ? _value.signupIsInFlux
          : signupIsInFlux // ignore: cast_nullable_to_non_nullable
              as bool,
      signupError: freezed == signupError
          ? _value.signupError
          : signupError // ignore: cast_nullable_to_non_nullable
              as SignUpErrorDetails?,
      signupStatusMessage: null == signupStatusMessage
          ? _value.signupStatusMessage
          : signupStatusMessage // ignore: cast_nullable_to_non_nullable
              as String,
      conflictingCredentials: freezed == conflictingCredentials
          ? _value.conflictingCredentials
          : conflictingCredentials // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      conflictingEmail: freezed == conflictingEmail
          ? _value.conflictingEmail
          : conflictingEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SignUpErrorDetailsCopyWith<$Res>? get signupError {
    if (_value.signupError == null) {
      return null;
    }

    return $SignUpErrorDetailsCopyWith<$Res>(_value.signupError!, (value) {
      return _then(_value.copyWith(signupError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OnboardingStateCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$_OnboardingStateCopyWith(
          _$_OnboardingState value, $Res Function(_$_OnboardingState) then) =
      __$$_OnboardingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
          bool signupIsInFlux,
      @JsonKey(includeFromJson: false, includeToJson: false)
          SignUpErrorDetails? signupError,
      @JsonKey(includeFromJson: false, includeToJson: false)
          String signupStatusMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
          AuthCredential? conflictingCredentials,
      @JsonKey(includeFromJson: false, includeToJson: false)
          String? conflictingEmail});

  @override
  $SignUpErrorDetailsCopyWith<$Res>? get signupError;
}

/// @nodoc
class __$$_OnboardingStateCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$_OnboardingState>
    implements _$$_OnboardingStateCopyWith<$Res> {
  __$$_OnboardingStateCopyWithImpl(
      _$_OnboardingState _value, $Res Function(_$_OnboardingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signupIsInFlux = null,
    Object? signupError = freezed,
    Object? signupStatusMessage = null,
    Object? conflictingCredentials = freezed,
    Object? conflictingEmail = freezed,
  }) {
    return _then(_$_OnboardingState(
      signupIsInFlux: null == signupIsInFlux
          ? _value.signupIsInFlux
          : signupIsInFlux // ignore: cast_nullable_to_non_nullable
              as bool,
      signupError: freezed == signupError
          ? _value.signupError
          : signupError // ignore: cast_nullable_to_non_nullable
              as SignUpErrorDetails?,
      signupStatusMessage: null == signupStatusMessage
          ? _value.signupStatusMessage
          : signupStatusMessage // ignore: cast_nullable_to_non_nullable
              as String,
      conflictingCredentials: freezed == conflictingCredentials
          ? _value.conflictingCredentials
          : conflictingCredentials // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      conflictingEmail: freezed == conflictingEmail
          ? _value.conflictingEmail
          : conflictingEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_OnboardingState extends _OnboardingState {
  _$_OnboardingState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
          this.signupIsInFlux = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
          this.signupError = null,
      @JsonKey(includeFromJson: false, includeToJson: false)
          this.signupStatusMessage = '',
      @JsonKey(includeFromJson: false, includeToJson: false)
          this.conflictingCredentials,
      @JsonKey(includeFromJson: false, includeToJson: false)
          this.conflictingEmail})
      : super._();

  factory _$_OnboardingState.fromJson(Map<String, dynamic> json) =>
      _$$_OnboardingStateFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool signupIsInFlux;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SignUpErrorDetails? signupError;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String signupStatusMessage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AuthCredential? conflictingCredentials;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? conflictingEmail;

  @override
  String toString() {
    return 'OnboardingState(signupIsInFlux: $signupIsInFlux, signupError: $signupError, signupStatusMessage: $signupStatusMessage, conflictingCredentials: $conflictingCredentials, conflictingEmail: $conflictingEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnboardingState &&
            (identical(other.signupIsInFlux, signupIsInFlux) ||
                other.signupIsInFlux == signupIsInFlux) &&
            (identical(other.signupError, signupError) ||
                other.signupError == signupError) &&
            (identical(other.signupStatusMessage, signupStatusMessage) ||
                other.signupStatusMessage == signupStatusMessage) &&
            (identical(other.conflictingCredentials, conflictingCredentials) ||
                other.conflictingCredentials == conflictingCredentials) &&
            (identical(other.conflictingEmail, conflictingEmail) ||
                other.conflictingEmail == conflictingEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signupIsInFlux, signupError,
      signupStatusMessage, conflictingCredentials, conflictingEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      __$$_OnboardingStateCopyWithImpl<_$_OnboardingState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OnboardingStateToJson(
      this,
    );
  }
}

abstract class _OnboardingState extends OnboardingState {
  factory _OnboardingState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
          final bool signupIsInFlux,
      @JsonKey(includeFromJson: false, includeToJson: false)
          final SignUpErrorDetails? signupError,
      @JsonKey(includeFromJson: false, includeToJson: false)
          final String signupStatusMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
          final AuthCredential? conflictingCredentials,
      @JsonKey(includeFromJson: false, includeToJson: false)
          final String? conflictingEmail}) = _$_OnboardingState;
  _OnboardingState._() : super._();

  factory _OnboardingState.fromJson(Map<String, dynamic> json) =
      _$_OnboardingState.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get signupIsInFlux;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  SignUpErrorDetails? get signupError;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get signupStatusMessage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  AuthCredential? get conflictingCredentials;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get conflictingEmail;
  @override
  @JsonKey(ignore: true)
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}
