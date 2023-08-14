import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_number/phone_number.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';

import 'main_test.dart' as main_test;

void main() {
  group('Authentication Integration Test', () {
    late Authentication authenticatorTestInstance;

    // Ensure Firebase is initialized before running tests
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await main_test.main();
      authenticatorTestInstance = Authentication();
    });

    testWidgets('Init Fuse & Fetch/Create Wallet', (WidgetTester tester) async {
      // Your test code using Firebase services
      // For example, Firestore queries, Authentication, etc.
      final store = await reduxStore;
      await authenticatorTestInstance.initFuse(
        // this code will not be waited for as runs once stream receives an event...
        onWalletInitialised: () {
          expect(
            fuseWalletSDK.smartWallet != null,
            true,
            reason: 'fuse wallet sdk has been successfully initialised',
          );
        },
      );
      var currentFuseStatus = store.state.userState.fuseAuthenticationStatus;
      log.info('Start checking fuse initialisation status');
      Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) async {
          expect(
            store.state.userState.fuseAuthenticationStatus
                .isNewFailureStatus(currentFuseStatus),
            false,
          );
          currentFuseStatus = store.state.userState.fuseAuthenticationStatus;
          if (currentFuseStatus == FuseAuthenticationStatus.authenticated) {
            expect(
              store.state.userState.smartWallet != null,
              true,
              reason: 'Fuse Smart wallet should be initialised now!',
            );
            expect(
              store.state.userState.walletAddress.isNotEmpty,
              true,
              reason:
                  'Fuse Smart wallet addess should not be empty as fuse authenticated!',
            );
            timer.cancel();
            return;
          }
        },
      );
    });

    test(
        'Can Request Firebase Verification code for PhoneNumber using firebase emulator',
        () async {
      final mockStore =
          await reduxStore; //TODO How to mock redux store for flutter_test ask ?
      expect(true, isFalse);
    });

    // test('Login Test', () async {
    //   final countryCode = CountryCode(
    //     dialCode: '+44',
    //     code: 'GB',
    //   );
    //   final phoneNumberNoCountry = '7905532512';
    //   final String phoneNumberFull =
    //       '${countryCode.dialCode}${phoneNumberNoCountry}';
    //   // setState(() {
    //   //   isPreloading = true;
    //   // });
    //   PhoneNumber? value = null;
    //   try {
    //     value = await phoneNumberUtil.parse(
    //       phoneNumberFull,
    //     );
    //   } catch (e) {
    //     // do nothing and try again....
    //   }
    //   try {
    //     value ??= await PhoneNumberUtil().parse(
    //       phoneNumberNoCountry,
    //       regionCode: countryCode.code,
    //     );
    //   } on Exception {
    //     rethrow;
    //   }

    //   expect(value, null, reason: 'Phone number util failed to parse number');

    //   await authenticatorTestInstance.login(
    //     loginDetails:
    //         PhoneLoginDetails(countryCode: countryCode, phoneNumber: value),
    //   );

    //   expect(result, true);
    // });

    // test('Signup Test', () async {
    //   final phoneNumber = '1234567890';

    //   final result = await authenticatorTestInstance.signup(phoneNumber);

    //   expect(result, true);
    // });

    // test('Verify Test', () async {
    //   final verificationCode = '1234';

    //   final result = await authenticatorTestInstance.verify(verificationCode);

    //   expect(result, true);
    // });
  });
}
