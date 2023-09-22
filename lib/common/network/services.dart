import 'package:dio/dio.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:injectable/injectable.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/common/router/vegi_debug_route_observer.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/new_version.dart';
import 'package:vegan_liverpool/services/apis/peeplEats.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/utils/onboard/web3Auth.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  RootRouter get rootRouter => DebugHelpers.inDebugMode
      ? RootRouterLogger(
          authGuard: AuthGuard(),
        )
      : RootRouterLogger(
          // RootRouter(
          authGuard: AuthGuard(),
        );

  // @lazySingleton
  // Future<FuseSDK?> get fuseWalletSDK => initWeb3Auth(); // this needs to be called always after we have a privateKey wcih can be obtained from logging in

  // @preResolve
  // Future<NewVersion> get newVersion => NewVersion.fromPackageInfo(); // ! BUG -> this causes app to fail before start because of the preresolve....
  @lazySingleton
  NewVersion get newVersion => NewVersion(
        iOSAppStoreCountry:
            'GB', // ~ https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
        iOSId: PackageConstants.bundleIdentifierHardCoded,
        androidId: PackageConstants.bundleIdentifierHardCoded,
      );

  // @lazySingleton
  // PeeplEatsService getVegiBackendService(@factoryParam Store<AppState> store) =>
  //     PeeplEatsService(Dio(), store);
}
