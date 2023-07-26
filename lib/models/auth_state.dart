import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

List<AuthState> fromJsonAuthStateList(dynamic json) =>
    fromSailsListOfObjectJson<AuthState>(AuthState.fromJson)(json);
AuthState? fromJsonAuthState(dynamic json) =>
    fromSailsObjectJson<AuthState>(AuthState.fromJson)(json);

@Freezed()
class AuthState with _$AuthState {
  @JsonSerializable()
  factory AuthState({
    required Map<String, String> phoneNumberToPrivateKeyMap,
  }) = _AuthState;

  const AuthState._();

  factory AuthState.initial() => AuthState(
        phoneNumberToPrivateKeyMap: <String, String>{},
      );

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$AuthStateFromJson(json),
      );
}

class AuthStateConverter
    implements JsonConverter<AuthState, Map<String, dynamic>?> {
  const AuthStateConverter();

  @override
  AuthState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null ? AuthState.fromJson(json) : AuthState.initial(),
      );

  @override
  Map<String, dynamic> toJson(AuthState instance) => tryCatchRethrowInline(
        () => instance.toJson(),
      );
}
