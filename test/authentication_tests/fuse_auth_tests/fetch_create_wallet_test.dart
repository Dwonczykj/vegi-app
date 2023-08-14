import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/onboard/fuseAuthUtils.dart';

import '../../initStore_for_test.dart';

void main() async {
  group('Authentication Integration Test', () {
    bool completed = false;
    bool succeeded = false;
    late final Store<AppState> store;
    late final LogIt log;
    Object? error;

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

    setUp(() async {
      await dotenv.load(fileName: Env.envFile);
      store = initStoreForTests() as Store<AppState>;
      // final _baseLogger = Logger();
      // log = LogIt(_baseLogger);
      // await configureDependencies(
      //   environment: Env.activeEnv,
      // );
      final dependencyInjection = GetIt.instance;
      dependencyInjection.registerFactory<LogIt>(() => LogIt(Logger()));
      log = dependencyInjection.get<LogIt>();
    });

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

      log.info(
        'New smart wallet created in fuse SDK with walletAddress: "${fuseWalletSDK.smartWallet.smartWalletAddress}" and accountAddress: "${fuseWalletSDK.smartWallet.ownerAddress}"',
      );

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
              'fuseWalletSDK.fetchWallet succeeded with Smart wallet address "${smartWallet.smartWalletAddress}"',);
        },
        onError: (Exception exception) async {
          log
              // ..error(
              //     'fuseWalletSDK.fetchWallet failed to fetch fuse smart wallet with error: "$exception"')
              .info(
                  'Authenticator._fetchCreateWallet trying to create a new fuse smart wallet as failed to fetch...',);
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
