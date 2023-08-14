import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logger/logger.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/new_version.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/services/apis/fxService.dart';
import 'package:vegan_liverpool/services/apis/locationService.dart';
import 'package:vegan_liverpool/services/apis/peeplEats.dart';
import 'package:vegan_liverpool/services/apis/peeplPay2.dart';
import 'package:vegan_liverpool/services/apis/stripePay2.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';
import 'package:vegan_liverpool/utils/stripe.dart';
import 'package:redux/redux.dart';

import '../test/env_test.dart';
import '../test/firebase/firebase_test_mock.dart';
import '../test/initStore_for_test.dart';
import '../test/register_dependencies.dart';
// import '../../main_test.dart' as main_test;

/// ~ Taken from https://stackoverflow.com/a/74477245
/// TODO: we also need to remember how to start the firebase emulator instance before running tests
/// and in setup, there needs to be an expect() emulator is running on port
/// the emulator code may be in the nodejs lib...
/// ~ https://www.notion.so/gember/Firebase-Emulator-Setting-up-and-Using-64c59408e482499a9a1ed07548fe09ae
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('$FuseWalletSDK', () {
    bool completed = false;
    bool succeeded = false;
    late final Store<AppState> store;
    late final LogIt log;
    Object? error;

    setUpAll(() async {
      await registerDependencies();
      log = getIt<LogIt>();
    });

    tearDown(methodCallLog.clear);

    void _onSmartWalletEvent(SmartWalletEvent event) {
      switch (event.name) {
        case 'smartWalletCreationStarted':
          print('smartWalletCreationStarted ${event.data}');
          break;
        case 'transactionHash':
          print('transactionHash ${event.data}');
          break;
        case 'smartWalletCreationSucceeded':
          print('smartWalletCreationSucceeded ${event.data}');
          completed = true;
          succeeded = true;
          error = null;
          // exit(1);
          break;
        case 'smartWalletCreationFailed':
          print('smartWalletCreationFailed ${event.data}');
          completed = true;
          succeeded = false;
          error = event.data;
          break;
        // exit(1);
      }
    }

    Stream<String> flattenStreams(Stream<SmartWalletEvent> source) async* {
      await for (final event in source) {
        yield event.name;
      }
    }

    Future<FuseWalletSDK> _initFuseWithCreds(String privateKey) async {
      final EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      final EthereumAddress accountAddress = credentials.address;
      // Create a project: https://developers.fuse.io
      print('privateKey: $privateKey');
      print('address: ${credentials.address.hexEip55}');
      final String publicApiKey = Secrets.FUSE_WALLET_SDK_PUBLIC_KEY;
      final FuseWalletSDK fuseWalletSDK = FuseWalletSDK(publicApiKey);

      final authSucceeded = await authenticateFuseSDKForTests(
        credentials,
        fuseWalletSDK,
      );
      expect(
        authSucceeded,
        true,
        reason: 'Unable to authenticate fuse wallet',
      );
      await fuseWalletSDK.authenticate(credentials);
      return fuseWalletSDK;
    }

    Future<FuseWalletSDK> _initFuseForTestsUsingNewMnemonic() async {
      final String mnemonic = Mnemonic.generate();
      final String privateKey = Mnemonic.privateKeyFromMnemonic(mnemonic);
      return _initFuseWithCreds(privateKey);
    }

    Future<FuseWalletSDK> _initFuseForTestsWithMenomic({
      required List<String> mnemonicWords,
    }) async {
      final mnemonic = mnemonicWords.join(' ');
      log
        ..info('restore wallet')
        ..info('compute pk');
      final String privateKey = Mnemonic.privateKeyFromMnemonic(mnemonic);
      return _initFuseWithCreds(privateKey);
    }

    test('Init Fuse & Fetch/Create Wallet', () async {
      final fuseWalletSDK = await _initFuseForTestsUsingNewMnemonic();

      // NOTE: This will fetch a wallet when the fuseWalletSDK is initialised
      // using a privateKey Credential that has already initialised a credential once before.
      final exceptionOrStreamFromFetch = await fuseWalletSDK.fetchWallet();

      expect(exceptionOrStreamFromFetch.hasError, true);

      final exceptionOrStream = await fuseWalletSDK.createWallet();

      expect(
        exceptionOrStream.hasError,
        false,
        reason: 'fuseSDK create wallet errored: ${exceptionOrStream.error}',
      );

      if (exceptionOrStream.hasError) {
        final defaultCreateWalletException =
            Exception('An error occurred while creating wallet.');
        final exception =
            exceptionOrStream.error ?? defaultCreateWalletException;
        print(exception);
        completed = true;
        succeeded = false;
        error = exception;
        // exit(1);
        return;
      }

      final smartWalletEventStream = exceptionOrStream.data!;
      final smartWalletEventNameStream = flattenStreams(smartWalletEventStream);

      smartWalletEventStream.listen(
        _onSmartWalletEvent,
        onError: (dynamic error) {
          print('Error occurred: $error');
          completed = true;
          succeeded = false;
          error = error;
          exit(1);
        },
      );

      expect(
        smartWalletEventNameStream,
        emitsInOrder([
          'smartWalletCreationStarted',
          // SmartWalletEvent(name: "smartWalletCreationStarted", data: {}),
          'transactionHash',
          // SmartWalletEvent(
          //   name: "transactionHash",
          //   data: anything as Map<String, dynamic>,
          // ),
          // AsyncLoading<void>(),
          // AsyncData<void>(null),
          'smartWalletCreationSucceeded',
          // SmartWalletEvent(
          //   name: "smartWalletCreationSucceeded",
          //   data: anything as Map<String, dynamic>,
          // ),
        ]),
      );

      // log.info(
      //   'New smart wallet created in fuse SDK with walletAddress: "${fuseWalletSDK.smartWallet.smartWalletAddress}" and accountAddress: "${fuseWalletSDK.smartWallet.ownerAddress}"',
      // );

      final exceptionOrStreamFromFetchAgain = await fuseWalletSDK.fetchWallet();

      expect(
        exceptionOrStreamFromFetchAgain.hasError,
        false,
        reason:
            'fetchWallet returned an error: ${exceptionOrStreamFromFetchAgain.error}',
      );

      expect(
        smartWalletEventNameStream,
        emitsInOrder([
          'smartWalletCreationStarted',
          // SmartWalletEvent(name: "smartWalletCreationStarted", data: {}),
          'transactionHash',
          // SmartWalletEvent(
          //   name: "transactionHash",
          //   data: anything as Map<String, dynamic>,
          // ),
          // AsyncLoading<void>(),
          // AsyncData<void>(null),
          'smartWalletCreationSucceeded',
          // SmartWalletEvent(
          //   name: "smartWalletCreationSucceeded",
          //   data: anything as Map<String, dynamic>,
          // ),
        ]),
      );
    });

    test('Check fuseSDK can init', () async {
      await authenticator.initFuse(
        onWalletInitialised: () {
          expect(fuseWalletSDK.smartWallet, isNotEmpty);
          // final fuseWalletSDK =
          //     await _initFuseForTestsWithMenomic(mnemonicWords: mnemonic);
          // final walletData = await fuseWalletSDK.fetchWallet();

          expect(
            fuseWalletSDK.smartWallet.smartWalletAddress,
            isNotEmpty,
            reason: 'SmartWalletAddress should be non empty',
          );
        },
      );

      return;
    });

    test('Check fuseSDK can recover wallet from mnemonic', () async {
      final mnemonic =
          'cancel, rubber, crucial, polar, protect, control, health, armor, order, night, denial, near'
              .split(', ');
      await authenticator.restoreFuseFromMnemonic(
        mnemonicWords: mnemonic,
      );
      expect(fuseWalletSDK.smartWallet, isNotEmpty);
      // final fuseWalletSDK =
      //     await _initFuseForTestsWithMenomic(mnemonicWords: mnemonic);
      // final walletData = await fuseWalletSDK.fetchWallet();

      expect(
        fuseWalletSDK.smartWallet.smartWalletAddress,
        '0x9092C642292a1481A0334D2174a734aF907594B9',
        reason: 'SmartWalletAddress should be deterministic from mnemonic used',
      );
      return;
    });

    test(
        'Check fuseSDK can fetch existing wallet when init fuseSDK already using same private credentials that has already created a wallet',
        () async {
      final privateKey =
          Secrets.FUSE_WALLET_SDK_PRIVATE_CREDENTIAL_FOR_UNIT_TEST_ONLY!;
      final fuseWalletSDK = await _initFuseWithCreds(privateKey);
      final walletData = await fuseWalletSDK.fetchWallet();
      expect(
        walletData.hasError,
        false,
        reason: 'WalletData has error: ${walletData.error}',
      );
      expect(walletData.hasData, true);
      return;
    });

    test(
      'Check that fuseSDK gets the walletAddress: "0xODFG" '
      'every time when sdk is initialised with accountAddress: "0xASDFASDF" and privateKey: "***********"',
      () async {
        final privateKey =
            Secrets.FUSE_WALLET_SDK_PRIVATE_CREDENTIAL_FOR_UNIT_TEST_ONLY!;
        final fuseWalletSDK = await _initFuseWithCreds(privateKey);
        final walletData = await fuseWalletSDK.fetchWallet();
        expect(walletData.hasError, false);
        expect(walletData.hasData, true);
        return;
      },
    );

    test('_fetchCreateWallet', () async {
      final fuseWalletSDK = await _initFuseForTestsUsingNewMnemonic();
      final walletData = await fuseWalletSDK.fetchWallet();
      walletData.pick(
        onData: (SmartWallet smartWallet) async {
          log.info(
            'fuseWalletSDK.fetchWallet succeeded with Smart wallet address "${smartWallet.smartWalletAddress}"',
          );
        },
        onError: (Exception exception) async {
          log
              // ..error(
              //     'fuseWalletSDK.fetchWallet failed to fetch fuse smart wallet with error: "$exception"')
              .info(
            'Authenticator._fetchCreateWallet trying to create a new fuse smart wallet as failed to fetch...',
          );
          final exceptionOrStream = await fuseWalletSDK.createWallet();
          expect(exceptionOrStream.hasError, false);
          if (exceptionOrStream.hasError) {
            log.error(
              'fuseWalletSDK.createWallet failed with error: "${exceptionOrStream.error}"',
              error: exceptionOrStream.error,
              stackTrace: StackTrace.current,
            );
            return;
          }
          expect(exceptionOrStream.hasData, true);
          if (exceptionOrStream.hasData) {
            final smartWalletEventStream = exceptionOrStream.data!;
            final smartWalletEventNameStream =
                flattenStreams(smartWalletEventStream);

            // smartWalletEventStream.listen(
            //   _onSmartWalletEvent,
            //   onError: (dynamic error) {
            //     print('Error occurred: $error');
            //     completed = true;
            //     succeeded = false;
            //     _error = error;
            //     exit(1);
            //   },
            // );

            // // final smartWalletEventStream = exceptionOrStream.data!;
            // smartWalletEventStream.listen(
            //   (SmartWalletEvent event) {
            //     switch (event.name) {
            //       case "smartWalletCreationStarted":
            //         log.info(
            //             'smartWalletCreationStarted ${event.data.toString()}');
            //         break;
            //       case "transactionHash":
            //         log.info(
            //             'smartWallet.Create.transactionHash "${event.data.toString()}"');
            //         break;
            //       case "smartWalletCreationSucceeded":
            //         log.info(
            //             'smartWalletCreationSucceeded ${event.data.toString()}');
            //         break;
            //       case "smartWalletCreationFailed":
            //         log.error(
            //             'fuseWalletSDK.createWallet transaction stream failed on chain with error ${event.data}');

            //         break;
            //     }
            //   },
            //   onError: (error) {
            //     log.error(
            //         'Authentication._fetchCreateWallet fuseWalletSDK.createWallet Error occurred: $error');
            //   },
            // );
            expect(
              smartWalletEventNameStream,
              emitsInOrder([
                'smartWalletCreationStarted',
                // SmartWalletEvent(name: "smartWalletCreationStarted", data: {}),
                'transactionHash',
                // SmartWalletEvent(
                //   name: "transactionHash",
                //   data: anything as Map<String, dynamic>,
                // ),
                // AsyncLoading<void>(),
                // AsyncData<void>(null),
                'smartWalletCreationSucceeded',
                // SmartWalletEvent(
                //   name: "smartWalletCreationSucceeded",
                //   data: anything as Map<String, dynamic>,
                // ),
              ]),
            );
          }
        },
      );
    });
  });
}
