import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/reducers/app_reducer.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

Store<AppState> initStoreForTests() => DevToolsStore<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware],
    );

Future<bool> authenticateFuseSDKForTests(
  // String privateKey,
  EthPrivateKey credentials,
  FuseWalletSDK fuseWalletSDK,
) async {
  // final EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  final DC<Exception, String> authRes = await fuseWalletSDK.authenticate(
    credentials,
  );
  if (authRes.hasData) {
    final jwt = authRes.data!;
    fuseWalletSDK.jwtToken = jwt;
    return true;
  } else if (authRes.hasError) {
    log.error(
      'Error occurred in FuseSDK authenticate: ${authRes.error}',
      error: authRes.error,
    );
    return false;
  } else {
    log.error(
      'Unkown Error occurred in FuseSDK authenticate',
    );
    return false;
  }
}
