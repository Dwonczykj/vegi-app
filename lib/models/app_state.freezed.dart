// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
mixin _$AppState {
  @AppEnvStateConverter()
  AppEnvState get appEnvState => throw _privateConstructorUsedError;
  @AuthStateConverter()
  AuthState get authState => throw _privateConstructorUsedError;
  @AppLogStateConverter()
  AppLogState get appLogState => throw _privateConstructorUsedError;
  @EscStateConverter()
  EscState get escState => throw _privateConstructorUsedError;
  @UserStateConverter()
  UserState get userState => throw _privateConstructorUsedError;
  @CashWalletStateConverter()
  CashWalletState get cashWalletState => throw _privateConstructorUsedError;
  @HomePageStateConverter()
  HomePageState get homePageState => throw _privateConstructorUsedError;
  @CartStateConverter()
  CartState get cartState => throw _privateConstructorUsedError;
  @MenuItemStateConverter()
  MenuItemState get menuItemState => throw _privateConstructorUsedError;
  @PastOrderStateConverter()
  PastOrderState get pastOrderState => throw _privateConstructorUsedError;
  @OnboardingStateConverter()
  OnboardingState get onboardingState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {@AppEnvStateConverter() AppEnvState appEnvState,
      @AuthStateConverter() AuthState authState,
      @AppLogStateConverter() AppLogState appLogState,
      @EscStateConverter() EscState escState,
      @UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @HomePageStateConverter() HomePageState homePageState,
      @CartStateConverter() CartState cartState,
      @MenuItemStateConverter() MenuItemState menuItemState,
      @PastOrderStateConverter() PastOrderState pastOrderState,
      @OnboardingStateConverter() OnboardingState onboardingState});

  $AppEnvStateCopyWith<$Res> get appEnvState;
  $AuthStateCopyWith<$Res> get authState;
  $AppLogStateCopyWith<$Res> get appLogState;
  $EscStateCopyWith<$Res> get escState;
  $UserStateCopyWith<$Res> get userState;
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  $HomePageStateCopyWith<$Res> get homePageState;
  $CartStateCopyWith<$Res> get cartState;
  $MenuItemStateCopyWith<$Res> get menuItemState;
  $PastOrderStateCopyWith<$Res> get pastOrderState;
  $OnboardingStateCopyWith<$Res> get onboardingState;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appEnvState = null,
    Object? authState = null,
    Object? appLogState = null,
    Object? escState = null,
    Object? userState = null,
    Object? cashWalletState = null,
    Object? homePageState = null,
    Object? cartState = null,
    Object? menuItemState = null,
    Object? pastOrderState = null,
    Object? onboardingState = null,
  }) {
    return _then(_value.copyWith(
      appEnvState: null == appEnvState
          ? _value.appEnvState
          : appEnvState // ignore: cast_nullable_to_non_nullable
              as AppEnvState,
      authState: null == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState,
      appLogState: null == appLogState
          ? _value.appLogState
          : appLogState // ignore: cast_nullable_to_non_nullable
              as AppLogState,
      escState: null == escState
          ? _value.escState
          : escState // ignore: cast_nullable_to_non_nullable
              as EscState,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      cashWalletState: null == cashWalletState
          ? _value.cashWalletState
          : cashWalletState // ignore: cast_nullable_to_non_nullable
              as CashWalletState,
      homePageState: null == homePageState
          ? _value.homePageState
          : homePageState // ignore: cast_nullable_to_non_nullable
              as HomePageState,
      cartState: null == cartState
          ? _value.cartState
          : cartState // ignore: cast_nullable_to_non_nullable
              as CartState,
      menuItemState: null == menuItemState
          ? _value.menuItemState
          : menuItemState // ignore: cast_nullable_to_non_nullable
              as MenuItemState,
      pastOrderState: null == pastOrderState
          ? _value.pastOrderState
          : pastOrderState // ignore: cast_nullable_to_non_nullable
              as PastOrderState,
      onboardingState: null == onboardingState
          ? _value.onboardingState
          : onboardingState // ignore: cast_nullable_to_non_nullable
              as OnboardingState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppEnvStateCopyWith<$Res> get appEnvState {
    return $AppEnvStateCopyWith<$Res>(_value.appEnvState, (value) {
      return _then(_value.copyWith(appEnvState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<$Res> get authState {
    return $AuthStateCopyWith<$Res>(_value.authState, (value) {
      return _then(_value.copyWith(authState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppLogStateCopyWith<$Res> get appLogState {
    return $AppLogStateCopyWith<$Res>(_value.appLogState, (value) {
      return _then(_value.copyWith(appLogState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EscStateCopyWith<$Res> get escState {
    return $EscStateCopyWith<$Res>(_value.escState, (value) {
      return _then(_value.copyWith(escState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserStateCopyWith<$Res> get userState {
    return $UserStateCopyWith<$Res>(_value.userState, (value) {
      return _then(_value.copyWith(userState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CashWalletStateCopyWith<$Res> get cashWalletState {
    return $CashWalletStateCopyWith<$Res>(_value.cashWalletState, (value) {
      return _then(_value.copyWith(cashWalletState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HomePageStateCopyWith<$Res> get homePageState {
    return $HomePageStateCopyWith<$Res>(_value.homePageState, (value) {
      return _then(_value.copyWith(homePageState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CartStateCopyWith<$Res> get cartState {
    return $CartStateCopyWith<$Res>(_value.cartState, (value) {
      return _then(_value.copyWith(cartState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MenuItemStateCopyWith<$Res> get menuItemState {
    return $MenuItemStateCopyWith<$Res>(_value.menuItemState, (value) {
      return _then(_value.copyWith(menuItemState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PastOrderStateCopyWith<$Res> get pastOrderState {
    return $PastOrderStateCopyWith<$Res>(_value.pastOrderState, (value) {
      return _then(_value.copyWith(pastOrderState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OnboardingStateCopyWith<$Res> get onboardingState {
    return $OnboardingStateCopyWith<$Res>(_value.onboardingState, (value) {
      return _then(_value.copyWith(onboardingState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@AppEnvStateConverter() AppEnvState appEnvState,
      @AuthStateConverter() AuthState authState,
      @AppLogStateConverter() AppLogState appLogState,
      @EscStateConverter() EscState escState,
      @UserStateConverter() UserState userState,
      @CashWalletStateConverter() CashWalletState cashWalletState,
      @HomePageStateConverter() HomePageState homePageState,
      @CartStateConverter() CartState cartState,
      @MenuItemStateConverter() MenuItemState menuItemState,
      @PastOrderStateConverter() PastOrderState pastOrderState,
      @OnboardingStateConverter() OnboardingState onboardingState});

  @override
  $AppEnvStateCopyWith<$Res> get appEnvState;
  @override
  $AuthStateCopyWith<$Res> get authState;
  @override
  $AppLogStateCopyWith<$Res> get appLogState;
  @override
  $EscStateCopyWith<$Res> get escState;
  @override
  $UserStateCopyWith<$Res> get userState;
  @override
  $CashWalletStateCopyWith<$Res> get cashWalletState;
  @override
  $HomePageStateCopyWith<$Res> get homePageState;
  @override
  $CartStateCopyWith<$Res> get cartState;
  @override
  $MenuItemStateCopyWith<$Res> get menuItemState;
  @override
  $PastOrderStateCopyWith<$Res> get pastOrderState;
  @override
  $OnboardingStateCopyWith<$Res> get onboardingState;
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appEnvState = null,
    Object? authState = null,
    Object? appLogState = null,
    Object? escState = null,
    Object? userState = null,
    Object? cashWalletState = null,
    Object? homePageState = null,
    Object? cartState = null,
    Object? menuItemState = null,
    Object? pastOrderState = null,
    Object? onboardingState = null,
  }) {
    return _then(_$_AppState(
      appEnvState: null == appEnvState
          ? _value.appEnvState
          : appEnvState // ignore: cast_nullable_to_non_nullable
              as AppEnvState,
      authState: null == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState,
      appLogState: null == appLogState
          ? _value.appLogState
          : appLogState // ignore: cast_nullable_to_non_nullable
              as AppLogState,
      escState: null == escState
          ? _value.escState
          : escState // ignore: cast_nullable_to_non_nullable
              as EscState,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      cashWalletState: null == cashWalletState
          ? _value.cashWalletState
          : cashWalletState // ignore: cast_nullable_to_non_nullable
              as CashWalletState,
      homePageState: null == homePageState
          ? _value.homePageState
          : homePageState // ignore: cast_nullable_to_non_nullable
              as HomePageState,
      cartState: null == cartState
          ? _value.cartState
          : cartState // ignore: cast_nullable_to_non_nullable
              as CartState,
      menuItemState: null == menuItemState
          ? _value.menuItemState
          : menuItemState // ignore: cast_nullable_to_non_nullable
              as MenuItemState,
      pastOrderState: null == pastOrderState
          ? _value.pastOrderState
          : pastOrderState // ignore: cast_nullable_to_non_nullable
              as PastOrderState,
      onboardingState: null == onboardingState
          ? _value.onboardingState
          : onboardingState // ignore: cast_nullable_to_non_nullable
              as OnboardingState,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AppState extends _AppState with DiagnosticableTreeMixin {
  _$_AppState(
      {@AppEnvStateConverter() required this.appEnvState,
      @AuthStateConverter() required this.authState,
      @AppLogStateConverter() required this.appLogState,
      @EscStateConverter() required this.escState,
      @UserStateConverter() required this.userState,
      @CashWalletStateConverter() required this.cashWalletState,
      @HomePageStateConverter() required this.homePageState,
      @CartStateConverter() required this.cartState,
      @MenuItemStateConverter() required this.menuItemState,
      @PastOrderStateConverter() required this.pastOrderState,
      @OnboardingStateConverter() required this.onboardingState})
      : super._();

  factory _$_AppState.fromJson(Map<String, dynamic> json) =>
      _$$_AppStateFromJson(json);

  @override
  @AppEnvStateConverter()
  final AppEnvState appEnvState;
  @override
  @AuthStateConverter()
  final AuthState authState;
  @override
  @AppLogStateConverter()
  final AppLogState appLogState;
  @override
  @EscStateConverter()
  final EscState escState;
  @override
  @UserStateConverter()
  final UserState userState;
  @override
  @CashWalletStateConverter()
  final CashWalletState cashWalletState;
  @override
  @HomePageStateConverter()
  final HomePageState homePageState;
  @override
  @CartStateConverter()
  final CartState cartState;
  @override
  @MenuItemStateConverter()
  final MenuItemState menuItemState;
  @override
  @PastOrderStateConverter()
  final PastOrderState pastOrderState;
  @override
  @OnboardingStateConverter()
  final OnboardingState onboardingState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(appEnvState: $appEnvState, authState: $authState, appLogState: $appLogState, escState: $escState, userState: $userState, cashWalletState: $cashWalletState, homePageState: $homePageState, cartState: $cartState, menuItemState: $menuItemState, pastOrderState: $pastOrderState, onboardingState: $onboardingState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('appEnvState', appEnvState))
      ..add(DiagnosticsProperty('authState', authState))
      ..add(DiagnosticsProperty('appLogState', appLogState))
      ..add(DiagnosticsProperty('escState', escState))
      ..add(DiagnosticsProperty('userState', userState))
      ..add(DiagnosticsProperty('cashWalletState', cashWalletState))
      ..add(DiagnosticsProperty('homePageState', homePageState))
      ..add(DiagnosticsProperty('cartState', cartState))
      ..add(DiagnosticsProperty('menuItemState', menuItemState))
      ..add(DiagnosticsProperty('pastOrderState', pastOrderState))
      ..add(DiagnosticsProperty('onboardingState', onboardingState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            (identical(other.appEnvState, appEnvState) ||
                other.appEnvState == appEnvState) &&
            (identical(other.authState, authState) ||
                other.authState == authState) &&
            (identical(other.appLogState, appLogState) ||
                other.appLogState == appLogState) &&
            (identical(other.escState, escState) ||
                other.escState == escState) &&
            (identical(other.userState, userState) ||
                other.userState == userState) &&
            (identical(other.cashWalletState, cashWalletState) ||
                other.cashWalletState == cashWalletState) &&
            (identical(other.homePageState, homePageState) ||
                other.homePageState == homePageState) &&
            (identical(other.cartState, cartState) ||
                other.cartState == cartState) &&
            (identical(other.menuItemState, menuItemState) ||
                other.menuItemState == menuItemState) &&
            (identical(other.pastOrderState, pastOrderState) ||
                other.pastOrderState == pastOrderState) &&
            (identical(other.onboardingState, onboardingState) ||
                other.onboardingState == onboardingState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appEnvState,
      authState,
      appLogState,
      escState,
      userState,
      cashWalletState,
      homePageState,
      cartState,
      menuItemState,
      pastOrderState,
      onboardingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppStateToJson(
      this,
    );
  }
}

abstract class _AppState extends AppState {
  factory _AppState(
      {@AppEnvStateConverter() required final AppEnvState appEnvState,
      @AuthStateConverter() required final AuthState authState,
      @AppLogStateConverter() required final AppLogState appLogState,
      @EscStateConverter() required final EscState escState,
      @UserStateConverter() required final UserState userState,
      @CashWalletStateConverter()
      required final CashWalletState cashWalletState,
      @HomePageStateConverter() required final HomePageState homePageState,
      @CartStateConverter() required final CartState cartState,
      @MenuItemStateConverter() required final MenuItemState menuItemState,
      @PastOrderStateConverter() required final PastOrderState pastOrderState,
      @OnboardingStateConverter()
      required final OnboardingState onboardingState}) = _$_AppState;
  _AppState._() : super._();

  factory _AppState.fromJson(Map<String, dynamic> json) = _$_AppState.fromJson;

  @override
  @AppEnvStateConverter()
  AppEnvState get appEnvState;
  @override
  @AuthStateConverter()
  AuthState get authState;
  @override
  @AppLogStateConverter()
  AppLogState get appLogState;
  @override
  @EscStateConverter()
  EscState get escState;
  @override
  @UserStateConverter()
  UserState get userState;
  @override
  @CashWalletStateConverter()
  CashWalletState get cashWalletState;
  @override
  @HomePageStateConverter()
  HomePageState get homePageState;
  @override
  @CartStateConverter()
  CartState get cartState;
  @override
  @MenuItemStateConverter()
  MenuItemState get menuItemState;
  @override
  @PastOrderStateConverter()
  PastOrderState get pastOrderState;
  @override
  @OnboardingStateConverter()
  OnboardingState get onboardingState;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
