import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/onboard/dialogs/signup.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
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

import 'package:auto_route/annotations.dart';

@RoutePage()
class SignUpEmailLinkScreen extends StatefulWidget {
  const SignUpEmailLinkScreen({Key? key}) : super(key: key);

  @override
  State<SignUpEmailLinkScreen> createState() => _SignUpEmailLinkScreenState();
}

class _SignUpEmailLinkScreenState extends State<SignUpEmailLinkScreen> {
  final fullNameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  bool isPreloading = false;

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainScreenViewModel>(
      converter: MainScreenViewModel.fromStore,
      distinct: true,
      onInit: (store) {
        if (store.state.userState.firebaseCredentials != null) {
          onBoardStrategy.reauthenticateUser().then(
            (reauthSucceeded) {
              if (reauthSucceeded &&
                  store.state.userState.walletAddress.isNotEmpty) {
                store.dispatch(getVegiWalletAccountDetails());
              }
            },
          );
        }
      },
      onWillChange: (previousViewModel, newViewModel) async {
        // final checked = checkAuth(
        //   oldViewModel: previousViewModel,
        //   newViewModel: newViewModel,
        //   routerContext: context,
        // );
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
          log.error(newViewModel.signupError!.toString());
          await Sentry.captureException(
            newViewModel.signupError!.toString(),
            stackTrace: StackTrace.current, // from catch (e, s)
          );
          if (newViewModel.signupError!.code != null) {
            final errCode = newViewModel.signupError!.code!;
            if (errCode == SignUpErrCode.userNotFound) {
              setState(() {});
            }
          }
        }
        // await checked.runNavigationIfNeeded();
      },
      builder: (context, viewmodel) {
        if (viewmodel.email.isNotEmpty) {
          emailController.text = viewmodel.email;
        }
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
                          PrimaryButton(
                            label: I10n.of(context).next_button,
                            preload: viewmodel.signupIsInFlux,
                            onPressedDisabled: () =>
                                StoreProvider.of<AppState>(context)
                                    .dispatch(SignupLoading(isLoading: false)),
                            disabled: viewmodel.signupIsInFlux,
                            onPressed: () async {
                              viewmodel.signInUserUsingEmailLink(
                                email: emailController.text,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => launchUrl(VEGI_PRIVACY_URL),
                            child: Text(
                              'By signing up, you agree to the vegi'
                              ' Terms & Conditions which can be found here',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
                ListTile(
                  title: const Text(Labels.emailAndPasswordSignonLabel),
                  onTap: () async {
                    await rootRouter
                        .replace(const SignUpWithEmailAndPasswordScreen());
                  },
                ),
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
