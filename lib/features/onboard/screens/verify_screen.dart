import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/common/router/routes.dart' as routes;
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/onboard.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({Key? key, this.verificationId}) : super(key: key);
  final String? verificationId;

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  String autoCode = '';
  TextEditingController codeController = TextEditingController(text: '');
  String currentText = '';
  final formKey = GlobalKey<FormState>();
  // bool isPreloading = false;
  bool isRouting = false;
  bool finishedRouting = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _route(VerifyOnboardViewModel viewModel) async {
  //   final success = viewModel
  //       .isLoggedIn; // ! needs to be the same condition as on mainscreen
  //   logFunctionCall(
  //     () {},
  //     className: '_VerifyPhoneNumberState',
  //     funcName: '_route',
  //     logMessage: 'routing with success = [$success]',
  //   );

  //   if (isRouting ||
  //       finishedRouting ||
  //       rootRouter.current.name != routes.VerifyPhoneNumber().routeName ||
  //       !success) {
  //     return;
  //   }
  //   if (success) {
  //     setState(() {
  //       finishedRouting = true;
  //     });
  //     // final store = await reduxStore;
  //     // if (store.state.userState.email.trim().isEmpty) {
  //     //   await rootRouter.push(const SetEmailOnboardingScreen());
  //     // } else if (store.state.userState.displayName.isEmpty) {
  //     //   await rootRouter.push(UserNameScreen());
  //     // } else if (store.state.userState.authType == BiometricAuth.none) {
  //     //   await rootRouter.push(const ChooseSecurityOption());
  //     // } else if (!store.state.userState.biometricallyAuthenticated) {
  //     //   await rootRouter.push(const PinCodeScreen());
  //     // } else {
  //     //   await rootRouter.push(const MainScreen());
  //     // }
  //     await onBoardStrategy.nextOnboardingPage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: StoreConnector<AppState, VerifyOnboardViewModel>(
        distinct: true,
        converter: VerifyOnboardViewModel.fromStore,
        onInitialBuild: (viewModel) {
          if (viewModel.firebaseCredentials != null &&
              viewModel.verificationId != null &&
              viewModel.firebaseCredentials is PhoneAuthCredential) {
            autoCode = (viewModel.firebaseCredentials! as PhoneAuthCredential)
                    .smsCode ??
                '';
            // setState(() {
            //   isPreloading = true;
            // });
            delayed(
              15000,
              () {
                viewModel.setLoading(false);
              },
              () => viewModel.verify(
                autoCode,
              ),
            );
          }
        },
        // onWillChange: (oldViewModel, newViewModel) {
        //   _route(newViewModel);
        // },
        builder: (_, viewModel) {
          final errMessage = _createErrorMessage(viewModel.signupError);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      '${I10n.of(context).we_just_sent}'
                      '${viewModel.phoneNumber}\n',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'A message has been sent to: ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      I10n.of(context).enter_verification_code,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: 280,
                        child: PinCodeTextField(
                          length: 6,
                          backgroundColor: Theme.of(context).canvasColor,
                          showCursor: false,
                          appContext: context,
                          enableActiveFill: true,
                          enablePinAutofill: false,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          controller: codeController,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            borderWidth: 4,
                            borderRadius: BorderRadius.circular(20),
                            shape: PinCodeFieldShape.underline,
                            inactiveColor: const Color(0xFFDDDDDD),
                            inactiveFillColor: Theme.of(context).canvasColor,
                            selectedFillColor: Theme.of(context).canvasColor,
                            disabledColor: Theme.of(context).primaryColor,
                            selectedColor:
                                Theme.of(context).colorScheme.onSurface,
                            activeColor:
                                Theme.of(context).colorScheme.onSurface,
                            activeFillColor: Theme.of(context).canvasColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                          onCompleted: (value) {
                            _verifyCode(viewModel, context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                      child: Text(viewModel.signupStatusMessage),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: PrimaryButton(
                        label: I10n.of(context).next_button,
                        width: MediaQuery.of(context).size.width * .9,
                        preload: viewModel.signupIsInFlux,
                        disabled: viewModel.signupIsInFlux,
                        onPressedDisabled: () =>
                            StoreProvider.of<AppState>(context)
                                .dispatch(SignupLoading(isLoading: false)),
                        onPressed: () {
                          _verifyCode(viewModel, context);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I10n.of(context).didnt_get_message,
                          style: const TextStyle(fontSize: 12),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 10),
                          ),
                          onPressed: () {
                            rootRouter.push(const SignUpScreen());
                          },
                          child: Text(
                            I10n.of(context).resend_code,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _verifyCode(VerifyOnboardViewModel viewModel, BuildContext context) {
    formKey.currentState!.validate();
    if (currentText.length == 6) {
      // setState(() {
      //   isPreloading = true;
      // });
      delayed(
        15000,
        () async {
          final store = StoreProvider.of<AppState>(context);
          if (store.state.onboardingState.signupIsInFlux) {
            await showErrorSnack(
              context: context,
              title: 'SMS Verfication',
              message: 'SMS verification taking too long,',
            );
            store.dispatch(SignupLoading(isLoading: false));
          }
        },
        () => viewModel.verify(
          codeController.text,
        ),
      );
    }
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
