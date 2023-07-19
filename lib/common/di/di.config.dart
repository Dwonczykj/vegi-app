// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:firebase_core/firebase_core.dart' as _i8;
import 'package:firebase_messaging/firebase_messaging.dart' as _i10;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i11;
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i14;
import 'package:logger/logger.dart' as _i16;
import 'package:package_info/package_info.dart' as _i19;
import 'package:phone_number/phone_number.dart' as _i23;
import 'package:redux/redux.dart' as _i25;
import 'package:vegan_liverpool/common/di/authenticator.dart' as _i37;
import 'package:vegan_liverpool/common/di/dio.dart' as _i34;
import 'package:vegan_liverpool/common/di/firebase.dart' as _i36;
import 'package:vegan_liverpool/common/di/logger_di.dart' as _i33;
import 'package:vegan_liverpool/common/di/network_info_di.dart' as _i38;
import 'package:vegan_liverpool/common/di/onboard.dart' as _i35;
import 'package:vegan_liverpool/common/di/package_info.dart' as _i39;
import 'package:vegan_liverpool/common/di/phone.dart' as _i32;
import 'package:vegan_liverpool/common/network/services.dart' as _i40;
import 'package:vegan_liverpool/common/router/routes.dart' as _i24;
import 'package:vegan_liverpool/initStore.dart' as _i31;
import 'package:vegan_liverpool/models/app_state.dart' as _i26;
import 'package:vegan_liverpool/new_version.dart' as _i18;
import 'package:vegan_liverpool/services/apis/blueBeaconService.dart' as _i4;
import 'package:vegan_liverpool/services/apis/fxService.dart' as _i6;
import 'package:vegan_liverpool/services/apis/locationService.dart' as _i15;
import 'package:vegan_liverpool/services/apis/peeplEats.dart' as _i20;
import 'package:vegan_liverpool/services/apis/peeplPay.dart' as _i21;
import 'package:vegan_liverpool/services/apis/peeplPay2.dart' as _i22;
import 'package:vegan_liverpool/services/apis/stripePay.dart' as _i27;
import 'package:vegan_liverpool/services/apis/stripePay2.dart' as _i28;
import 'package:vegan_liverpool/utils/connectionChecker.dart' as _i17;
import 'package:vegan_liverpool/utils/log/log_it.dart' as _i30;
import 'package:vegan_liverpool/utils/onboard/authentication.dart' as _i3;
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart' as _i13;
import 'package:vegan_liverpool/utils/stripe.dart' as _i29;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authenticationInjectableModule = _$AuthenticationInjectableModule();
    final dioDi = _$DioDi();
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    final servicesModule = _$ServicesModule();
    final onBoardStrategy = _$OnBoardStrategy();
    final networkInfoDi = _$NetworkInfoDi();
    final loggerDi = _$LoggerDi();
    final packageInfoDi = _$PackageInfoDi();
    final phone = _$Phone();
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Authentication>(
        () => authenticationInjectableModule.authenticator);
    gh.lazySingleton<_i4.BlueBeaconService>(() => _i4.BlueBeaconService());
    gh.factory<_i5.Dio>(() => dioDi.dio);
    gh.lazySingleton<_i6.FXService>(() => _i6.FXService(gh<_i5.Dio>()));
    gh.lazySingleton<_i7.FirebaseAnalytics>(
        () => firebaseInjectableModule.firebaseAnalytics);
    await gh.factoryAsync<_i8.FirebaseApp>(
      () => firebaseInjectableModule.firebaseApp,
      preResolve: true,
    );
    gh.lazySingleton<_i9.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i10.FirebaseMessaging>(
        () => firebaseInjectableModule.firebaseMessaging);
    gh.lazySingleton<_i11.FirebaseRemoteConfig>(
        () => firebaseInjectableModule.firebaseRemoteConfig);
    gh.lazySingleton<_i12.FuseWalletSDK>(() => servicesModule.fuseWalletSDK);
    gh.lazySingleton<_i13.IOnBoardStrategy>(
        () => onBoardStrategy.onBoardStrategy);
    gh.lazySingleton<_i14.InternetConnectionChecker>(
        () => networkInfoDi.dataConnectionChecker);
    gh.lazySingleton<_i15.LocationService>(
        () => _i15.LocationService(gh<_i5.Dio>()));
    gh.lazySingleton<_i16.Logger>(() => loggerDi.logger);
    gh.lazySingleton<_i17.NetworkInfo>(
        () => _i17.NetworkInfo(gh<_i14.InternetConnectionChecker>()));
    gh.lazySingleton<_i18.NewVersion>(() => servicesModule.newVersion);
    await gh.factoryAsync<_i19.PackageInfo>(
      () => packageInfoDi.packageInfo,
      preResolve: true,
    );
    gh.lazySingleton<_i20.PeeplEatsService>(
        () => _i20.PeeplEatsService(gh<_i5.Dio>()));
    gh.lazySingleton<_i21.PeeplPayService>(
        () => _i21.PeeplPayService(gh<_i5.Dio>()));
    gh.lazySingleton<_i22.PeeplPayService>(() => _i22.PeeplPayService());
    gh.lazySingleton<_i23.PhoneNumberUtil>(() => phone.phoneNumberUtil);
    gh.lazySingleton<_i24.RootRouter>(() => servicesModule.rootRouter);
    gh.singletonAsync<_i25.Store<_i26.AppState>>(() => registerModule.store());
    gh.lazySingleton<_i27.StripePayService>(
        () => _i27.StripePayService(gh<_i5.Dio>()));
    gh.lazySingleton<_i28.StripePayService>(() => _i28.StripePayService());
    gh.lazySingleton<_i29.StripeService>(() => _i29.StripeService());
    gh.lazySingleton<_i30.LogIt>(() => _i30.LogIt(gh<_i16.Logger>()));
    return this;
  }
}

class _$RegisterModule extends _i31.RegisterModule {}

class _$Phone extends _i32.Phone {}

class _$LoggerDi extends _i33.LoggerDi {}

class _$DioDi extends _i34.DioDi {}

class _$OnBoardStrategy extends _i35.OnBoardStrategy {}

class _$FirebaseInjectableModule extends _i36.FirebaseInjectableModule {}

class _$AuthenticationInjectableModule
    extends _i37.AuthenticationInjectableModule {}

class _$NetworkInfoDi extends _i38.NetworkInfoDi {}

class _$PackageInfoDi extends _i39.PackageInfoDi {}

class _$ServicesModule extends _i40.ServicesModule {}
