import 'dart:collection';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<void> initWeb3Auth() async {
  if (AppConfig.useWeb3Auth) {
    // no need for mnemonics as will use web3auth to manage users for us and give us the credentials from the web3auth
    // final jwtToken = store.state.userState.jwtToken;
    // assert(jwtToken.isNotEmpty, "JWT Token can not be empty");
    final web3authClientId =
        "BC0MvXuyPpJErPKwsa53LP8Bp7r3-RsGdWkTFZEbtk8383xYOztF7HANcUtxaIdB90R3uVCC-JyU_6LOpH6OPHE"; // Secrets.WEB3AUTH_CLIENT_ID;
    Uri redirectUrl;
    if (Platform.isAndroid) {
      // redirectUrl = Uri.parse('fuse-sdk-exmple://io.fuse.examplewallet/auth');
      redirectUrl = Uri.parse(
          'vegi://com.vegiapp.vegi/auth'); // ~  android/app/src/main/AndroidManifest.xml:54
    } else if (Platform.isIOS) {
      // redirectUrl = Uri.parse('io.fuse.examplewallet://openlogin');
      redirectUrl = Uri.parse('com.vegiapp.vegi://openlogin');
    } else {
      throw UnKnownException('Unknown platform');
    }
    // if (Platform.isAndroid) {
    //   redirectUrl = Uri.parse('w3a://com.example.w3aflutter/auth');
    // } else if (Platform.isIOS) {
    //   redirectUrl = Uri.parse('com.example.w3aflutter://openlogin');
    // } else {
    //   throw UnKnownException('Unknown platform');
    // }

    // For login with firebase we need the following bespoke config
    // ~ https://github.com/Web3Auth/web3auth-pnp-examples/blob/8c5398317cffed6deb61228d32b74a0db3bd2862/flutter/flutter-firebase-example/lib/main.dart#L64C5-L72C11
    // ~ web3auth dashboard setup -> https://web3auth.io/docs/content-hub/guides/firebase#setup-your-web3auth-dashboard
    final loginConfig = HashMap<String, LoginConfigItem>();
    loginConfig['jwt'] = LoginConfigItem(
      verifier:
          // "web3auth-firebase-vegi-app-verifier", // get it from web3auth dashboard
          "web3auth-firebase-testnet-vegi", // get it from web3auth dashboard
      typeOfLogin: TypeOfLogin.jwt,
      name: "Custom JWT Login",
      clientId: web3authClientId, // web3auth's plug and play client id
    );
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#229954";
    await Web3AuthFlutter.init(Web3AuthOptions(
        clientId: web3authClientId,
        // chainNamespace: ChainNamespace.eip155,
        network: Network
            .testnet, //Env.isProd || Env.isQA ? Network.mainnet : Network.testnet,
        redirectUrl: redirectUrl,
        // whiteLabel: WhiteLabelData(
        //   dark: true,
        //   name: "vegi app",
        //   theme: themeMap,
        // ),
        loginConfig: loginConfig));

    // This performs authentication and gets the private-
    // key of the existing user if a user is already logged in
    // from within the web3auth flutter packages local shared prefs on the device
    await Web3AuthFlutter.initialize();
    final String privateKey = await Web3AuthFlutter.getPrivKey();
    log.debug(privateKey);
    if (privateKey.isNotEmpty) {
      log.debug('Web3AuthResponse Success: $privateKey');
      await registerFuseSDK(privateKey: privateKey);
    } else {
      // else init the fuseSDK once have the private key from logging in to firebase and getting web3auth.login response
      // GetIt.instance.registerSingleton<FuseSDK?>(null);
      return;
    }
  } else {
    // do nothing as using backup firebase cloud store
    // TODO:  Cloud Store init goes here
  }
  return;
}

/// The function retrieves a JWT token from Firebase and returns a Web3AuthResponse.
/// ~ https://web3auth.io/docs/content-hub/guides/firebase
Future<void> defiAuthenticate({
  required UserCredential credential,
}) async {
  late final String privateKey;
  final store = await reduxStore;
  if (AppConfig.useWeb3Auth) {
    final idToken = (await credential.user?.getIdToken(true)).toString();
    final response = await Web3AuthFlutter.login(LoginParams(
        mfaLevel: MFALevel.NONE,
        loginProvider: Provider.jwt,
        extraLoginOptions: ExtraLoginOptions(
          id_token: idToken, // * key Firebase JWT Token here
          verifierIdField: "sub", // same as your JWT Verifier ID
          domain: 'com.vegiapp.vegi',
        )));
    store.dispatch(SignupLoading(isLoading: false));
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('privateKey', response.privKey.toString());
    privateKey = response.privKey.toString();
  } else {
    privateKey = await loadPrivateKeyFromFirebase();
  }
  await registerFuseSDK(privateKey: privateKey);
  try {
    final fuseSDK = fuseWalletSDK;
    await _emitWallet(fuseSDK.wallet);
  } on Exception catch (e, s) {
    log.error(
      'Unable to emit fuseSDK smartWallet: $e',
      error: e,
      stackTrace: s,
    );
  }
  return;
}

Future<String> loadPrivateKeyFromFirebase() async {
  // Define the read rules
  // ~ https://firebase.google.com/docs/firestore/solutions/role-based-access#rules

  // ~ https://firebase.google.com/docs/firestore/query-data/get-data#dart

  final uid = firebaseAuth.currentUser?.uid;
  if (uid == null) {
    log.error(
        'Firebase uid is null as no firebase user logged in. Should always be logged in to init web3auth.');
    throw Exception(
        'Firebase uid is null as no firebase user logged in. Should always be logged in to init web3auth.');
  }
  late final String mn;
  try {
    final docRef = firebaseFirestore
        .collection(Secrets.FIREBASE_USER_DETAILS_COLLECTION_ID)
        .doc(uid);
    final doc = await docRef.get();
    if (doc.exists == false || (doc.data() as Map<String, dynamic>).containsKey(Secrets.FIREBASE_USER_DETAILS_COLLECTION_FIELD1) == false) {
      mn = Mnemonic.generate();
      docRef.set(<String, dynamic>{
        Secrets.FIREBASE_USER_DETAILS_COLLECTION_FIELD1: mn,
      });
      log.debug("Successfully created new backup for wallet: \"${mn}\"");
    } else {
      final data = doc.data() as Map<String, dynamic>;
      if(!data.containsKey(Secrets.FIREBASE_USER_DETAILS_COLLECTION_FIELD1)){
        
      }
      mn = data[Secrets.FIREBASE_USER_DETAILS_COLLECTION_FIELD1];
      log.debug("Successfully retrieved backup for wallet: \"${mn}\"");
    }
  } on Exception catch (e, s) {
    // TODO
    log.error(
      "Error getting ud doc from firebase for logged in user: \"$uid\" with error: $e",
      stackTrace: s,
    );
    return '';
  }

  final privateKey = Mnemonic.privateKeyFromMnemonic(mn);
  log.debug("Save privateKey: \"${privateKey}\"");
  return privateKey;
}

Future<FuseSDK?> registerFuseSDK({
  required String privateKey,
}) async {
  final store = await reduxStore;
  try {
    if (privateKey.isEmpty || store.state.userState.privateKey.isEmpty) {
      if (store.state.userState.privateKey.isEmpty) {
        privateKey = await loadPrivateKeyFromFirebase();
      } else {
        privateKey = store.state.userState.privateKey;
      }
    }
    if (!GetIt.instance.isRegistered<FuseSDK>()) {
      final credentials = EthPrivateKey.fromHex(privateKey);
      final fuseSDK = await FuseSDK.init(
        Secrets.FUSE_WALLET_SDK_PUBLIC_KEY,
        credentials,
        withPaymaster: true,
      );
      GetIt.instance.registerSingleton<FuseSDK>(fuseSDK);
      store
        ..dispatch(CreateLocalAccountSuccess(
          // mnemonicStr.split(' '),
          privateKey,
          credentials,
          // accountAddress.toString(),
        ));
      return fuseSDK;
    }
  } on Exception catch (e, s) {
    log.error(
      'Unable to init fuseSDK smart wallet: $e',
      error: e,
      stackTrace: s,
    );
  }
  return null;
}

Future<void> _emitWallet(EtherspotWallet userWallet) async {
  logFunctionCall<void>(
    className: 'Authentication',
    funcName: '_emitWallet',
  );
  await saveSmartWallet(
    smartWallet: userWallet,
  );
  final store = await reduxStore;
  store
    // ..dispatch(
    //   SetSmartWalletInMemory(
    //     smartWallet: userWallet,
    //   ),
    // )
    ..dispatch(
      SetUserAuthenticationStatus(
        fuseStatus: FuseAuthenticationStatus.authenticated,
      ),
    )
    ..dispatch(
      SignUpFailed(
        error: null,
      ),
    )
    ..dispatch(
      SignUpLoadingMessage(
        message: '',
      ),
    )
    ..dispatch(SignupLoading(isLoading: false))
    ..dispatch(getVegiWalletAccountDetails())
    ..dispatch(setRandomUserAvatarIfNone());

  await firebaseOnboarding.nextOnboardingPage();
}

Future<void> saveSmartWallet({
  required EtherspotWallet smartWallet,
}) async {
  logFunctionCall<void>(
    className: 'Authentication',
    funcName: 'saveSmartWallet',
  );
  final store = await reduxStore;
  try {
    store.dispatch(
      GotWalletDataSuccess(
        walletAddress: smartWallet.getSender(),
      ),
    );
  } catch (e, s) {
    log.error(
      'ERROR - setupWalletCall',
      error: e,
      stackTrace: s,
    );
  }
}

Future<bool> Function() defiSignout() {
  return () async {
    try {
      await Web3AuthFlutter.logout();
      return true;
    } on UserCancelledException {
      print("User cancelled.");
    } on UnKnownException {
      print("Unknown exception occurred");
    }
    return false;
  };
}

// VoidCallback _login(Future<Web3AuthResponse> Function() chosenSigninMethod) {
//   return () async {
//     try {
//       final Web3AuthResponse response = await chosenSigninMethod();
//       final prefs = await SharedPreferences.getInstance(); // instead of relying on the package, we can alterntivly set the private key ourself.
//       await prefs.setString('privateKey', response.privKey.toString());
//       setState(() {
//         _result = response.toString();
//         logoutVisible = true;
//       });
//     } on UserCancelledException {
//       log.debug("User cancelled.");
//     } on UnKnownException {
//       log.error("Unknown exception occurred");
//     }
//   };
// }

/// The function retrieves a JWT token from Firebase and returns a Web3AuthResponse.
/// ~ https://web3auth.io/docs/content-hub/guides/firebase
// Future<Web3AuthResponse> _withJWTFromFirebase() async {
//   var idToken = (await reduxStore).state.userState.jwtToken;
//   try {
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: 'custom+id_token@firebase.login', password: 'Welcome@W3A');
//     idToken = (await credential.user?.getIdToken(true)).toString();
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }

//   return Web3AuthFlutter.login(LoginParams(
//       loginProvider: Provider.jwt,
//       mfaLevel: MFALevel.NONE,
//       extraLoginOptions: ExtraLoginOptions(
//         id_token: idToken, // * key JWT Token here
//         domain: 'firebase',
//       )));
// }

Future<String> Function() _smartWalletAddress() {
  return () async {
    final fuseSDK = await fuseWalletSDK;
    return fuseSDK.wallet.getSender();
  };
}

Future<String> Function() _privKey(Future<String?> Function() method) {
  return () async {
    try {
      final String? response = await Web3AuthFlutter.getPrivKey();
      return response!;
    } on UserCancelledException {
      log.debug("User cancelled.");
    } on UnKnownException {
      log.error("Unknown exception occurred");
    }
    return '';
  };
}

Future<String> Function() _userInfo(Future<TorusUserInfo> Function() method) {
  return () async {
    try {
      final TorusUserInfo response = await Web3AuthFlutter.getUserInfo();
      return response.toString();
    } on UserCancelledException {
      log.debug("User cancelled.");
    } on UnKnownException {
      log.error("Unknown exception occurred");
    }
    return '';
  };
}

// Future<bool> authenticateSDK(
//   Store<AppState> store, {
//   required EthPrivateKey credentials,
// }) async {
//   // final EthPrivateKey credentials =
//   //     EthPrivateKey.fromHex(store.state.userState.privateKey);
//   final DC<Exception, String> authRes = await fuseWalletSDK.authenticate(
//     credentials,
//   );
//   if (authRes.hasData) {
//     final jwt = authRes.data!;
//     store
//       ..dispatch(SetJWTSuccess(jwt))
//       ..dispatch(
//         SetUserAuthenticationStatus(
//           fuseStatus: FuseAuthenticationStatus.created,
//         ),
//       );
//     fuseWalletSDK.jwtToken = jwt;
//     return true;
//   } else if (authRes.hasError) {
//     store
//       ..dispatch(
//         SetUserAuthenticationStatus(
//           fuseStatus: FuseAuthenticationStatus.failedAuthentication,
//         ),
//       )
//       ..dispatch(
//         SignUpFailed(
//           error: SignUpErrorDetails(
//             title: 'Fuse authentication failed',
//             message: 'Error occurred in authenticate: ${authRes.error}',
//           ),
//         ),
//       );
//     return false;
//   } else {
//     store.dispatch(
//       SetUserAuthenticationStatus(
//         fuseStatus: FuseAuthenticationStatus.failedAuthentication,
//       ),
//     );
//     final s = StackTrace.current;
//     const errMsg =
//         'Bad AuthRes from Fuse Authentication did not contain either data or an error';
//     log.error(errMsg, stackTrace: s);
//     return false;
//   }
// }
