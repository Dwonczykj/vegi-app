import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/auth_state.dart';
import 'package:vegan_liverpool/redux/actions/auth_actions.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, RegisterNewFusePrivateKey>(_setLoginLoading).call,
]);

AuthState _setLoginLoading(
  AuthState state,
  RegisterNewFusePrivateKey action,
) {
  final phoneNumber =
      '${action.phoneNumberCountryCode}${action.phoneNumberNoCountry}';
  final newMap = state.phoneNumberToPrivateKeyMap
    ..removeWhere((key, value) => key == phoneNumber)
    ..addAll({
      phoneNumber: action.fusePrivateKey,
    });
  return state.copyWith(
    phoneNumberToPrivateKeyMap: newMap,
  );
}
