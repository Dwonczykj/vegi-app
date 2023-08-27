import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/reducers/app_env_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/app_log_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/auth_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/cart_state_reducers.dart';
import 'package:vegan_liverpool/redux/reducers/cash_wallet_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/esc_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/home_page_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/menu_item_reducers.dart';
import 'package:vegan_liverpool/redux/reducers/onboarding_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/past_orders_reducer.dart';
import 'package:vegan_liverpool/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    appEnvState: appEnvReducer(state.appEnvState, action),
    authState: authReducer(state.authState, action),
    appLogState: appLogReducer(state.appLogState, action),
    escState: escReducer(state.escState, action),
    userState: userReducers(state.userState, action),
    cashWalletState: cashWalletReducers(state.cashWalletState, action),
    homePageState: homePageReducers(state.homePageState, action),
    cartState: cartStateReducers(state.cartState, action),
    menuItemState: menuItemReducers(state.menuItemState, action),
    pastOrderState: pastOrdersReducer(state.pastOrderState, action),
    onboardingState: onboardingReducer(state.onboardingState, action),
  );
}
