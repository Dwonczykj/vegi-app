// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$$_AppStateFromJson(Map<String, dynamic> json) => _$_AppState(
      appEnvState: const AppEnvStateConverter()
          .fromJson(json['appEnvState'] as Map<String, dynamic>?),
      authState: const AuthStateConverter()
          .fromJson(json['authState'] as Map<String, dynamic>?),
      appLogState: const AppLogStateConverter()
          .fromJson(json['appLogState'] as Map<String, dynamic>?),
      escState: const EscStateConverter()
          .fromJson(json['escState'] as Map<String, dynamic>?),
      userState: const UserStateConverter()
          .fromJson(json['userState'] as Map<String, dynamic>?),
      cashWalletState: const CashWalletStateConverter()
          .fromJson(json['cashWalletState'] as Map<String, dynamic>?),
      homePageState: const HomePageStateConverter()
          .fromJson(json['homePageState'] as Map<String, dynamic>?),
      cartState: const CartStateConverter()
          .fromJson(json['cartState'] as Map<String, dynamic>?),
      menuItemState: const MenuItemStateConverter()
          .fromJson(json['menuItemState'] as Map<String, dynamic>?),
      pastOrderState: const PastOrderStateConverter()
          .fromJson(json['pastOrderState'] as Map<String, dynamic>?),
      onboardingState: const OnboardingStateConverter()
          .fromJson(json['onboardingState'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_AppStateToJson(_$_AppState instance) =>
    <String, dynamic>{
      'appEnvState': const AppEnvStateConverter().toJson(instance.appEnvState),
      'authState': const AuthStateConverter().toJson(instance.authState),
      'appLogState': const AppLogStateConverter().toJson(instance.appLogState),
      'escState': const EscStateConverter().toJson(instance.escState),
      'userState': const UserStateConverter().toJson(instance.userState),
      'cashWalletState':
          const CashWalletStateConverter().toJson(instance.cashWalletState),
      'homePageState':
          const HomePageStateConverter().toJson(instance.homePageState),
      'cartState': const CartStateConverter().toJson(instance.cartState),
      'menuItemState':
          const MenuItemStateConverter().toJson(instance.menuItemState),
      'pastOrderState':
          const PastOrderStateConverter().toJson(instance.pastOrderState),
      'onboardingState':
          const OnboardingStateConverter().toJson(instance.onboardingState),
    };
