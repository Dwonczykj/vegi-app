import 'package:redux_thunk/redux_thunk.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class UpdateEnvInAppState {
  UpdateEnvInAppState({
    required this.env,
  });

  final String env;

  @override
  String toString() {
    return 'UpdateEnvInAppState : env:"$env"';
  }
}

class UpdateBuildInformation {
  UpdateBuildInformation({
    required this.majorVersion,
    required this.minorVersion,
  });

  final String majorVersion;
  final String minorVersion;

  @override
  String toString() {
    return 'UpdateBuildInformation : majorVersion:"$majorVersion", minorVersion:"$minorVersion"';
  }
}

ThunkAction<AppState> checkIfAppEnvChanged() {
  return (Store<AppState> store) async {
    if(store.state.appEnvState.appEnvironmentChanged){
      try {
        store
          .dispatch(UpdateEnvInAppState(
            env: Env.activeEnv,
          ));
      } catch (e, s) {
        log.error('ERROR - checkIfAppEnvChanged $e', stackTrace: s);
      }
    }
  };
}

ThunkAction<AppState> checkIfAppVersionWasUpdated() {
  return (Store<AppState> store) async {
    if((store.state.appEnvState.versionInfo?.compareTo(PackageConstants.buildVersionInfo) ?? 0) < 0){
      try {
        store
          .dispatch(UpdateBuildInformation(
            majorVersion: PackageConstants.buildVersionMajor,
            minorVersion: PackageConstants.buildVersionMinor,
          ));
      } catch (e, s) {
        log.error('ERROR - checkIfAppVersionWasUpdated $e', stackTrace: s);
      }
    }
  };
}
