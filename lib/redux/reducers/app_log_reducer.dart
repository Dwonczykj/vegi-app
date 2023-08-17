import 'package:redux/redux.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_log_state.dart';
import 'package:vegan_liverpool/models/auth_state.dart';
import 'package:vegan_liverpool/models/log_event.dart';
import 'package:vegan_liverpool/redux/actions/app_log_actions.dart';
import 'package:vegan_liverpool/redux/actions/auth_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';

final appLogReducer = combineReducers<AppLogState>([
  TypedReducer<AppLogState, LogoutRequestSuccess>(_logoutSuccess).call,
  TypedReducer<AppLogState, AddAppLog>(_addLogEvent).call,
]);

AppLogState _logoutSuccess(
  AppLogState state,
  LogoutRequestSuccess action,
) =>
    AppLogState.initial();

AppLogState _addLogEvent(
  AppLogState state,
  AddAppLog action,
) {
  return state.copyWith(
    logs: state.logs.lastN(999)
      ..add(
        LogEvent(
          message: action.message,
          information: action.additionalInfo,
          timestamp: DateTime.now(),
        ),
      ),
  );
}
