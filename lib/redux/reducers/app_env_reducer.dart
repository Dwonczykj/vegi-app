import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/app_env_state.dart';
import 'package:vegan_liverpool/redux/actions/app_env_actions.dart';

final appEnvReducer = combineReducers<AppEnvState>([
  TypedReducer<AppEnvState, UpdateEnvInAppState>(_updateEnvInAppState).call,
  TypedReducer<AppEnvState, UpdateBuildInformation>(_updateBuildInformation).call,
]);

AppEnvState _updateEnvInAppState(
  AppEnvState state,
  UpdateEnvInAppState action,
) {
  return state.copyWith(
    env: action.env,
  );
}

AppEnvState _updateBuildInformation(
  AppEnvState state,
  UpdateBuildInformation action,
) => state.copyWith(
    appMajorVersion: action.majorVersion,
    appMinorVersion: action.minorVersion,
  );
