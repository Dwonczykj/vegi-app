import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_env_state.dart';
import 'package:vegan_liverpool/models/app_log_state.dart';
import 'package:vegan_liverpool/models/auth_state.dart';
import 'package:vegan_liverpool/models/cash_wallet_state.dart';
import 'package:vegan_liverpool/models/home_page_state.dart';
import 'package:vegan_liverpool/models/menu_item_state.dart';
import 'package:vegan_liverpool/models/onboarding_state.dart';
import 'package:vegan_liverpool/models/past_order_state.dart';
import 'package:vegan_liverpool/models/user_cart_state.dart';
import 'package:vegan_liverpool/models/user_state.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@immutable
@Freezed()
class AppState with _$AppState {
  @JsonSerializable()
  factory AppState({
    @AppEnvStateConverter() required AppEnvState appEnvState,
    @AuthStateConverter() required AuthState authState,
    @AppLogStateConverter() required AppLogState appLogState,
    @UserStateConverter() required UserState userState,
    @CashWalletStateConverter() required CashWalletState cashWalletState,
    @HomePageStateConverter() required HomePageState homePageState,
    @UserCartStateConverter() required UserCartState cartState,
    @MenuItemStateConverter() required MenuItemState menuItemState,
    @PastOrderStateConverter() required PastOrderState pastOrderState,
    @OnboardingStateConverter() required OnboardingState onboardingState,
  }) = _AppState;

  const AppState._();

  factory AppState.initial() {
    return AppState(
      appEnvState: AppEnvState.initial(),
      authState: AuthState.initial(),
      appLogState: AppLogState.initial(),
      userState: UserState.initial(),
      cashWalletState: CashWalletState.initial(),
      homePageState: HomePageState.initial(),
      cartState: UserCartState.initial(),
      menuItemState: MenuItemState.initial(),
      pastOrderState: PastOrderState.initial(),
      onboardingState: OnboardingState.initial(),
    );
  }

  factory AppState.fromJsonForPersistor(dynamic json) {
    return AppState(
      appEnvState: const AppEnvStateConverter()
          .fromJson(json['appEnvState'] as Map<String, dynamic>?),
      authState: const AuthStateConverter()
          .fromJson(json['authState'] as Map<String, dynamic>?),
      appLogState: const AppLogStateConverter()
          .fromJson(json['appLog'] as Map<String, dynamic>?),
      userState: const UserStateConverter()
          .fromJson(json['userState'] as Map<String, dynamic>?),
      cashWalletState: const CashWalletStateConverter()
          .fromJson(json['cashWalletState'] as Map<String, dynamic>?),
      homePageState: HomePageState.initial(),
      cartState: UserCartState.initial(),
      menuItemState: MenuItemState.initial(),
      pastOrderState: const PastOrderStateConverter()
          .fromJson(json['pastOrderState'] as Map<String, dynamic>?),
      onboardingState: OnboardingState.initial(),
    );
  }

  factory AppState.fromJson(dynamic json) => tryCatchRethrowInline(
        () => _$AppStateFromJson(json as Map<String, dynamic>),
      );

  @override
  Map<String, dynamic> toJson() {
    return tryCatchRethrowInline(() => super.toJson());
  }
}
