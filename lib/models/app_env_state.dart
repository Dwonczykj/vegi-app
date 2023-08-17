import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/di/package_info.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/version.dart';

part 'app_env_state.freezed.dart';
part 'app_env_state.g.dart';

List<AppEnvState> fromJsonAppEnvStateList(dynamic json) =>
    fromSailsListOfObjectJson<AppEnvState>(AppEnvState.fromJson)(json);
AppEnvState? fromJsonAppEnvState(dynamic json) =>
    fromSailsObjectJson<AppEnvState>(AppEnvState.fromJson)(json);

@Freezed()
class AppEnvState with _$AppEnvState {
  @JsonSerializable()
  factory AppEnvState({
    required String env,
    required String appMajorVersion,
    required String appMinorVersion,
  }) = _AppEnvState;

  const AppEnvState._();

  factory AppEnvState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$AppEnvStateFromJson(json),
      );

  factory AppEnvState.initial() => AppEnvState(
        env: Env.activeEnv,
        appMajorVersion: packageInfo.version,
        appMinorVersion: packageInfo.buildNumber,
      );

  String get appVersion => '$appMajorVersion.$appMinorVersion';

  bool get appUpdateDownloaded => false;

  bool get appEnvironmentChanged => env != Env.activeEnv;

  Version? get versionInfo =>
      Version.tryParse(appVersion);
}

class AppEnvStateConverter
    implements JsonConverter<AppEnvState, Map<String, dynamic>?> {
  const AppEnvStateConverter();

  @override
  AppEnvState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null ? AppEnvState.fromJson(json) : AppEnvState.initial(),
      );

  @override
  Map<String, dynamic> toJson(AppEnvState instance) => instance.toJson();
}
