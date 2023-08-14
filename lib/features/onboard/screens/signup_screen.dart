import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:carrier_info/carrier_info.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/onboard/dialogs/signup.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/logoutDialog.dart';
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListFunnel.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/mainScreen.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController(text: '');
  final phoneController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  CountryCode countryCode = CountryCode(dialCode: '+44', code: 'GB');
  bool isPreloading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_updateCountryCode);
    super.initState();
  }

  Future<void> _updateCountryCode(_) async {
    try {
      String? isoCode;
      if (Platform.isAndroid) {
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainScreenViewModel>(
      converter: MainScreenViewModel.fromStore,
      distinct: true,
      onInit: (store) {
        final userState = store.state.userState;
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
            newViewModel.signupError != null &&
            newViewModel.signupError?.message != null) {
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
            stackTrace: StackTrace.current,
          );
        }
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
                          ? 'Please enter your phone number to reauthenticate'
                          : I10n.of(context).enter_phone_number,
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
                          const SizedBox(height: 40),
                          PrimaryButton(
                            label: I10n.of(context).next_button,
                            preload: viewmodel.signupIsInFlux,
                            disabled: viewmodel.signupIsInFlux,
                            onPressedDisabled: () =>
                                StoreProvider.of<AppState>(context)
                                    .dispatch(SignupLoading(isLoading: false)),
                            onPressed: () {
                              parsePhoneNumber(
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
              if (DebugHelpers.inDebugMode)
                GestureDetector(
                  onTap: () => _showAlternativeSignonPicker(context, viewmodel),
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

  Future<Exception?> parsePhoneNumber({
    required MainScreenViewModel viewmodel,
  }) async {
    viewmodel.setLoading(true);
    final String phoneNumber = '${countryCode.dialCode}${phoneController.text}';
    var value = await parsePhoneDetails(
      countryCode: countryCode,
      phoneNoCountry: phoneController.text,
    );
    final dummyCountryCodeDontUse = await parseCountryCode(
      countryCode: countryCode.code ?? 'GB',
    );
    if (value == null) {
      viewmodel.setLoading(false);
      return null;
    }

    viewmodel.signin(
      countryCode: countryCode,
      phoneNumber: value,
    );
    return null;
  }

  @override
  void dispose() {
    phoneController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  void _showAlternativeSignonPicker(
    BuildContext context,
    MainScreenViewModel viewmodel,
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
                // ListTile(
                //   title: const Text(Labels.googleSignonLabel),
                //   onTap: () async {
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
                if (viewmodel.phoneNumber.isNotEmpty) ...[
                  ListTile(
                    title: const Text(Labels.emailAndPasswordSignonLabel),
                    onTap: () async {
                      await rootRouter
                          .replace(const SignUpWithEmailAndPasswordScreen());
                    },
                  ),
                  // if (DebugHelpers.inDebugMode)
                  //   ListTile(
                  //     title: const Text(Labels.emailLinkSignonLabel),
                  //     onTap: () async {
                  //       await rootRouter.replace(const SignUpEmailLinkScreen());
                  //     },
                  //   ),
                ],
                ListTile(
                  title: Text(Labels.signupButtonLabelLogout(context)),
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _logout(
    BuildContext context,
  ) async {
    await rootRouter.pop();
    await showDialog<Widget>(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }
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
