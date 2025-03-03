import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:carrier_info/carrier_info.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/src/store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/common/router/routes.dart' as routes;
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/onboard/dialogs/signup.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListFunnel.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/redux/viewsmodels/mainScreen.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/url.dart';

typedef SignUp = void Function(
  CountryCode,
  PhoneNumber,
  void Function() onSuccess,
  void Function(dynamic error) onError,
);

@RoutePage()
class SignUpWithEmailAndPasswordScreen extends StatefulWidget {
  const SignUpWithEmailAndPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmailAndPasswordScreen> createState() =>
      _SignUpWithEmailAndPasswordScreenState();
}

class _SignUpWithEmailAndPasswordScreenState
    extends State<SignUpWithEmailAndPasswordScreen> {
  final fullNameController = TextEditingController(text: '');
  final emailController = TextEditingController(
      text: DebugHelpers.inDebugMode ? Secrets.testEmails[0] : '');
  final passwordController = TextEditingController(
      text: DebugHelpers.inDebugMode ? Secrets.testEmailPasswords[0] : '');
  final phoneController = TextEditingController(
      text: DebugHelpers.inDebugMode ? Secrets.testPhoneNumbers[0] : '');
  CountryCode countryCode = DebugHelpers.inDebugMode
      ? CountryCode(dialCode: Secrets.testPhoneNumberCountryCode, code: 'US')
      : CountryCode(dialCode: '+44', code: 'GB');
  final _formKey = GlobalKey<FormState>();

  bool isRouting = false;
  bool finishedRouting = false;
  bool isPreloading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  Future<void> _updateCountryCode(_) async {
    try {
      String? isoCode;
      if (Platform.isAndroid) {
        if (await Permission.location.isPermanentlyDenied) {
          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.

          bool isShown = await Permission.location.shouldShowRequestRationale;
          final userOpennedAppSettings = await openAppSettings();
          if (!userOpennedAppSettings) {
            log.info(
              'Android user decided not to reneable location permission using app settings for looking up the carrier code on the signup_screen',
              stackTrace: StackTrace.current,
            );
          }
        } else if (await Permission.location.isGranted) {
          // Access the cell location or carrier information here
        } else {
          // Request permission if not granted
          final status = await Permission.location.request();
          if (status.isGranted) {
            // Permission granted, access the information
          } else {
            // Permission denied, handle accordingly
          }
        }
        final androidInfo = await CarrierInfo.getAndroidInfo();
        if ((androidInfo?.telephonyInfo.length ?? 0) >= 1) {
          isoCode = androidInfo?.telephonyInfo[0].isoCountryCode;
        }
      }
      if (Platform.isIOS) {
        final iosInfo = await CarrierInfo.getIosInfo();
        if (iosInfo.carrierData.isNotEmpty) {
          isoCode = iosInfo.carrierData[0].isoCountryCode;
        }
      }
      final currentCountryCode = isoCode;
      if (currentCountryCode != null) {
        final Map<String, String> localeData = codes.firstWhere(
          (Map<String, String> code) =>
              code['code'].toString().toLowerCase() ==
              currentCountryCode.toLowerCase(),
        );
        if (mounted &&
            localeData.containsKey('dial_code') &&
            localeData.containsKey('code')) {
          setState(() {
            countryCode = CountryCode(
              dialCode: localeData['dial_code'],
              code: localeData['code'],
            );
          });
        }
      }
    } catch (e, s) {
      log.error(
        'Failed to deduce sim country code: $e',
        stackTrace: s,
      );
    }
  }

  Future<Exception?> parsePhoneNumberAndSigninEmail({
    required MainScreenViewModel viewmodel,
  }) async {
    viewmodel.setLoading(true);
    return await delayed(15000, () async {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      if (store.state.onboardingState.signupIsInFlux) {
        await showErrorSnack(
          context: context,
          title: 'Email authentication',
          message: 'Email authentication taking too long,',
        );
        store.dispatch(
          SignupLoading(isLoading: false),
        );
      }
      return;
    }, () async {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      var phoneNumber = await parsePhoneDetails(
        countryCode: countryCode,
        phoneNoCountry: phoneController.text,
      );
      // final String phoneNumberStr = '${countryCode.dialCode}${phoneController.text}';
      // final dummyCountryCodeDontUse = await parseCountryCode(
      //   countryCode: countryCode.code ?? 'GB',
      // );

      if (phoneNumber != null) {
        // viewmodel.setLoading(false);
        store.dispatch(
          SetPhoneNumberSuccess(
            countryCode: countryCode,
            phoneNumber: phoneNumber,
          ),
        );
      }
      return viewmodel.signinEmailAndPassword(
        email: emailController.text.toLowerCase().trim(),
        password: passwordController.text,
      );
    });
  }

  // Future<void> _route(MainScreenViewModel viewModel) async {
  //   final success = viewModel.isLoggedIn;
  //   logFunctionCall(
  //     () {},
  //     className: '_SignUpWithEmailAndPasswordScreenState',
  //     funcName: '_route',
  //     logMessage: 'routing with success = [$success]',
  //   );
  //   if (isRouting ||
  //       finishedRouting ||
  //       rootRouter.current.name !=
  //           routes.SignUpWithEmailAndPasswordScreen().routeName) {
  //     return;
  //   }
  //   if (success) {
  //     setState(() {
  //       finishedRouting = true;
  //     });
  //     final store = await reduxStore;
  //     //TODO: Add PhoneOnboarding Screen
  //     if (store.state.userState.phoneNumber.isEmpty) {
  //       // await rootRouter.push(
  //       //   const SetPhoneOnboardingScreen(),
  //       // );
  //       const msg = 'Users cannot login using email and password if have not '
  //           'already registered their phone number.\n Please register using phone number';
  //       log.error(msg);
  //       showErrorSnack(
  //         context: context,
  //         title: 'Whoops',
  //         message: msg,
  //       );
  //     } else if (store.state.userState.displayName.isEmpty) {
  //       await rootRouter.push(UserNameScreen());
  //     } else if (store.state.userState.authType == BiometricAuth.none) {
  //       await rootRouter.push(const ChooseSecurityOption());
  //     } else if (!store.state.userState.biometricallyAuthenticated) {
  //       await rootRouter.push(const PinCodeScreen());
  //     } else {
  //       await rootRouter.push(const MainScreen());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainScreenViewModel>(
      converter: MainScreenViewModel.fromStore,
      distinct: true,
      onInit: (store) {
        final userState = store.state.userState;
        if (userState.email.isNotEmpty) {
          if (emailController.text.isNotEmpty &&
              emailController.text != userState.email) {
            passwordController.text = "";
          }
          emailController.text = userState.email;
        }
        if (userState.isoCode.isNotEmpty &&
            userState.countryCode.isNotEmpty &&
            userState.phoneNumberNoCountry.isNotEmpty) {
          countryCode = CountryCode(
            dialCode: userState.countryCode,
            code: userState.isoCode,
          );
          phoneController.text = userState.phoneNumberNoCountry;
        }
      },
      onWillChange: (previousViewModel, newViewModel) async {
        if (newViewModel.signupError != previousViewModel?.signupError &&
            newViewModel.signupError != null) {
          await showErrorSnack(
            title: newViewModel.signupError!.title,
            message: newViewModel.signupError!.message,
            context: context,
            margin: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
              bottom: 120,
            ),
          );
          log.error(
            newViewModel.signupError!.toString(),
            sentryHint: 'Error signup email and password: ',
          );
          if (newViewModel.signupError!.code != null) {
            final errCode = newViewModel.signupError!.code!;
            if (errCode == SignUpErrCode.userNotFound) {
              setState(() {});
            }
            // return;
          }
        }
        // await _route(newViewModel);
        // await checked.runNavigationIfNeeded();
      },
      builder: (context, viewmodel) {
        final errMessage = _createErrorMessage(viewmodel.signupError);
        return MyScaffold(
          automaticallyImplyLeading: false,
          resizeToAvoidBottomInset: false,
          title: viewmodel.hasLoggedInBefore
              ? 'Reauthenticate'
              : I10n.of(context).sign_up,
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      viewmodel.hasLoggedInBefore
                          ? 'Please enter your email to reauthenticate'
                          : 'Please enter your email',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Theme.of(context).canvasColor,
                        highlightColor: Theme.of(context).canvasColor,
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                const SignUpDialog(),
                          );
                        },
                        child: Center(
                          child: Text(
                            I10n.of(context).why_do_we_need_this,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                CountryCodePicker(
                                  onChanged: (countryCode_) {
                                    setState(() {
                                      countryCode = countryCode_;
                                    });
                                    log.verbose(
                                      'CountryCode changed to ${countryCode_.dialCode}',
                                    );
                                  },
                                  searchDecoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    fillColor: Theme.of(context).canvasColor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                  dialogSize: Size(
                                    MediaQuery.of(context).size.width * .9,
                                    MediaQuery.of(context).size.height * 0.85,
                                  ),
                                  searchStyle: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  initialSelection: countryCode.code,
                                  favorite: const <String>[
                                    'GB', // /Users/joeyd/.pub-cache/hosted/pub.dartlang.org/country_code_picker-2.0.2/lib/country_codes.dart:1174
                                    'US', // /Users/joeyd/.pub-cache/hosted/pub.dartlang.org/country_code_picker-2.0.2/lib/country_codes.dart:1179
                                  ],
                                  showDropDownButton: true,
                                  dialogTextStyle: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                Container(
                                  height: 35,
                                  width: 1,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  margin: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    key: ValueKey(
                                        "SignUpScreenPhoneNoCountryField"),
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    autofocus: true,
                                    validator: (String? value) => value!.isEmpty
                                        ? 'Please enter mobile number'
                                        : null,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 10,
                                      ),
                                      hintText: I10n.of(context).phoneNumber,
                                      border: InputBorder.none,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          if (errMessage.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              errMessage,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                          Center(
                            child: Text(viewmodel.signupStatusMessage),
                          ),
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: true,
                              validator: (String? value) => value!.isEmpty
                                  ? 'Please enter your email'
                                  : null,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                hintText: 'email',
                                border: InputBorder.none,
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              autocorrect: false,
                              validator: (String? value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter your password';
                                } else if (value == null) {
                                  return null;
                                } else if (viewmodel.signupError != null) {
                                  return viewmodel.signupError!.title;
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                hintText: 'password',
                                border: InputBorder.none,
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          if (errMessage.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              errMessage,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                          const SizedBox(height: 40),
                          Center(
                            child: Text(viewmodel.signupStatusMessage),
                          ),
                          PrimaryButton(
                            label: I10n.of(context).next_button,
                            preload: viewmodel.signupIsInFlux,
                            disabled: viewmodel.signupIsInFlux,
                            onPressedDisabled: () =>
                                StoreProvider.of<AppState>(context)
                                    .dispatch(SignupLoading(isLoading: false)),
                            onPressed: () async {
                              parsePhoneNumberAndSigninEmail(
                                viewmodel: viewmodel,
                              ).then((e) {
                                if (e != null) {
                                  showErrorSnack(
                                    message: I10n.of(context).invalid_number,
                                    title:
                                        I10n.of(context).something_went_wrong,
                                    context: context,
                                    margin: const EdgeInsets.only(
                                      top: 8,
                                      right: 8,
                                      left: 8,
                                      bottom: 120,
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // GestureDetector(
                          //   onTap: () => launchUrl(VEGI_PRIVACY_URL),
                          //   child: Text(
                          //     'By signing up, you agree to the vegi'
                          //     ' Terms & Conditions which can be found here',
                          //     style: TextStyle(
                          //       color: Colors.grey[500],
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                          Messages.vegiPrivacyTnCsAnchorLink(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => peeplEatsService
                    .requestPasswordResetForEmail(
                      email: emailController.text.trim().toLowerCase(),
                    )
                    .then(
                      (emailResetLink) => emailResetLink != null
                          ? launchUrl(emailResetLink)
                          : showInfoSnack(
                              context,
                              title:
                                  'Email not able to reset for this email. Please use phone auth to register.',
                            ),
                    ),
                child: const Text(
                  'Reset password',
                  style: TextStyle(
                    color: themeLightShade1200,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              if (DebugHelpers.inDebugMode)
                GestureDetector(
                  onTap: () => _showAlternativeSignonPicker(context),
                  child: Text(
                    'Alternative sign-in methods',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _createErrorMessage(SignUpErrorDetails? errorDetails) {
    if (errorDetails == null || errorDetails.code == null) {
      return '';
    } else if (errorDetails.code! == SignUpErrCode.userNotFound) {
      return 'No user found for that email. Please signup with phone number to add an email address.';
    } else if (errorDetails.code! == SignUpErrCode.wrongPassword) {
      return 'Incorrect password';
    } else {
      return '';
    }
  }

  void _showAlternativeSignonPicker(
    BuildContext context,
  ) =>
      showModalBottomSheet<Widget>(
        useRootNavigator: true,
        context: context,
        builder: (context) => BottomSheet(
          onClosing: () {},
          builder: (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(Labels.phoneSignonLabel),
                  onTap: () async {
                    // Navigator.pop(context);
                    await rootRouter.replace(const SignUpScreen());
                  },
                ),
                // if (DebugHelpers.inDebugMode)
                //   ListTile(
                //     title: const Text(Labels.emailLinkSignonLabel),
                //     onTap: () async {
                //       await rootRouter.replace(const SignUpEmailLinkScreen());
                //     },
                //   ),
                // ListTile(
                //   title: const Text(Labels.googleSignonLabel),
                //   onTap: () async {
                //     // Navigator.pop(context);
                //     await onBoardStrategy.signInWithGoogle();
                //   },
                // ),
                // ListTile(
                //   title: const Text(Labels.appleSignonLabel),
                //   onTap: () async {
                //     // Navigator.pop(context);
                //     await onBoardStrategy.signInWithApple();
                //   },
                // ),
              ],
            ),
          ),
        ),
      );
}
