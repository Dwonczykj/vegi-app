import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart' as routes;
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/onboard/dialogs/signup.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
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
class SetEmailOnboardingScreen extends StatefulWidget {
  const SetEmailOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<SetEmailOnboardingScreen> createState() =>
      _SetEmailOnboardingScreenState();
}

class _SetEmailOnboardingScreenState extends State<SetEmailOnboardingScreen> {
  final fullNameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  bool notifyMeWhenLaunch = true;
  final _formKey = GlobalKey<FormState>();
  bool isRouting = false;

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
          title: Labels.registerEmailOnboardingScreenTitle,
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: <Widget>[
                    Text(
                      Messages.emailPleaseEnterToHelpProtectYourAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
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
                            disabled: viewmodel.signupIsInFlux,
                            onPressed: () async {
                              await viewmodel.setEmail(
                                email: emailController.text,
                                onComplete: () async {
                                  // await onBoardStrategy.nextOnboardingPage();
                                },
                                onError: (errStr) {
                                  log.warn(
                                      'Unable to update email for user on vegi with error: $errStr',);
                                  if (DebugHelpers.inDebugMode) {
                                    showErrorSnack(
                                      context: context,
                                      title: 'Unable to update email on vegi',
                                      message: 'Error: $errStr',
                                    );
                                  }
                                },
                              );
                              await onBoardStrategy.nextOnboardingPage();
                              // await _route(viewmodel);
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => launchUrl(VEGI_PRIVACY_URL),
                            child: Text(
                              Labels.vegiPrivacyTnCs,
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ColoredBox(
                            color: Colors.transparent,
                            child: CupertinoFormRow(
                              prefix: Row(
                                children: <Widget>[
                                  Icon(
                                    // Wifi icon is updated based on switch value.
                                    notifyMeWhenLaunch
                                        ? Icons.notification_add
                                        : Icons.notifications_off,
                                    color: notifyMeWhenLaunch
                                        ? CupertinoColors.systemGreen
                                        : CupertinoColors.systemGrey,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    notifyMeWhenLaunch
                                        ? Labels.notifyMeWhenYouRelease
                                        : Labels.dontNotifyMeWhenYouRelease,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              helper: Text(
                                notifyMeWhenLaunch
                                    ? Messages.willEmailOnceLive
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              child: CupertinoSwitch(
                                // This bool value toggles the switch.
                                value: notifyMeWhenLaunch,
                                thumbColor: notifyMeWhenLaunch
                                    ? themeShade600
                                    : themeShade600.withOpacity(0.5),
                                trackColor: notifyMeWhenLaunch
                                    ? CupertinoColors.systemGrey
                                        .withOpacity(0.95)
                                    : CupertinoColors.systemGrey
                                        .withOpacity(0.15),
                                activeColor: themeShade650.withOpacity(0.50),
                                onChanged: (bool? value) {
                                  // This is called when the user toggles the switch
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    notifyMeWhenLaunch = value;
                                  });
                                  viewmodel.subscribeToEmailToNotifications(
                                    email: emailController.text,
                                    receiveNotifications: value,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _route(MainScreenViewModel viewModel) async {
  //   if (isRouting ||
  //       rootRouter.current.name !=
  //           routes.SetEmailOnboardingScreen().routeName) {
  //     return;
  //   }
  //   logFunctionCall(
  //     () {},
  //     className: '_SetEmailOnboardingState',
  //     funcName: '_route',
  //   );
  //   await onBoardStrategy.nextOnboardingPage();
  // }

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
}
