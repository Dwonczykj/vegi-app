import 'dart:collection';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/auth_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<FuseSDK> initWeb3Auth() async {
  late final EthPrivateKey credentials;
  late final FuseSDK fuseSDK;
  if (AppConfig.useWeb3Auth) {
    // no need for mnemonics as will use web3auth to manage users for us and give us the credentials from the web3auth
    // final jwtToken = store.state.userState.jwtToken;
    // assert(jwtToken.isNotEmpty, "JWT Token can not be empty");
    Uri redirectUrl;
    if (Platform.isAndroid) {
      redirectUrl = Uri.parse('fuse-sdk-exmple://io.fuse.examplewallet/auth');
    } else if (Platform.isIOS) {
      redirectUrl = Uri.parse('io.fuse.examplewallet://openlogin');
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
    final loginConfig = HashMap<String, LoginConfigItem>();
    loginConfig['jwt'] = LoginConfigItem(
      verifier: "web3auth-firebase-examples", // get it from web3auth dashboard
      typeOfLogin: TypeOfLogin.jwt,
      name: "Firebase JWT Login",
      clientId:
          Secrets.WEB3AUTH_CLIENT_ID, // web3auth's plug and play client id
    );
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#229954";
    await Web3AuthFlutter.init(Web3AuthOptions(
        clientId: Secrets.WEB3AUTH_CLIENT_ID,
        network: Network.mainnet,
        redirectUrl: redirectUrl,
        whiteLabel: WhiteLabelData(
          dark: true,
          name: "vegi app",
          theme: themeMap,
        ),
        loginConfig: loginConfig));

    // This performs authentication and gets the private-
    // key of the existing user if a user is already logged in
    // from within the web3auth flutter packages local shared prefs on the device
    await Web3AuthFlutter.initialize();

    final String privateKey = await Web3AuthFlutter.getPrivKey();
    log.debug(privateKey);
    if (privateKey.isNotEmpty) {
      log.debug('Web3AuthResponse Success: $privateKey');
      credentials = EthPrivateKey.fromHex(privateKey);
      fuseSDK = await FuseSDK.init(
        Secrets.FUSE_WALLET_SDK_PUBLIC_KEY,
        credentials,
      );
    }
  } else {
    // ! old auth not accepted any longer as of commit e529d93cd2965ac96623c69da67f30e162f14677
    throw Exception('Application error: Web3Auth is only accepted methodology');
  }
  return fuseSDK;
}

/// The function retrieves a JWT token from Firebase and returns a Web3AuthResponse.
/// ~ https://web3auth.io/docs/content-hub/guides/firebase
Future<Web3AuthResponse> defiAuthenticate({
  required UserCredential credential,
}) async {
  final idToken = (await credential.user?.getIdToken(true)).toString();
  final response = await Web3AuthFlutter.login(LoginParams(
      loginProvider: Provider.jwt,
      mfaLevel: MFALevel.NONE,
      extraLoginOptions: ExtraLoginOptions(
        id_token: idToken, // * key Firebase JWT Token here
        domain: 'firebase',
      )));
  (await reduxStore).dispatch(SignupLoading(isLoading: false));
  return response;
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
