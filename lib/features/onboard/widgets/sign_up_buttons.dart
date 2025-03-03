// import 'dart:async';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:vegan_liverpool/common/router/routes.dart';
// import 'package:vegan_liverpool/constants/analytics_events.dart';
// import 'package:vegan_liverpool/constants/enums.dart';
// import 'package:vegan_liverpool/features/onboard/dialogs/warn_before_recreate.dart';
// import 'package:vegan_liverpool/features/onboard/widgets/sign_up_button.dart';
// import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
// import 'package:vegan_liverpool/features/shared/widgets/transparent_button.dart';
// import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
// import 'package:vegan_liverpool/generated/l10n.dart';
// import 'package:vegan_liverpool/models/app_state.dart';
// import 'package:vegan_liverpool/redux/actions/user_actions.dart';
// import 'package:vegan_liverpool/redux/viewsmodels/splash.dart';
// import 'package:vegan_liverpool/services.dart';
// import 'package:vegan_liverpool/utils/analytics.dart';
// import 'package:vegan_liverpool/utils/constants.dart';
// import 'package:vegan_liverpool/utils/constants.dart' as VegiConstants;
// import 'package:vegan_liverpool/utils/log/log.dart';

// class SignUpButtons extends StatefulWidget {
//   const SignUpButtons({Key? key}) : super(key: key);

//   @override
//   State<SignUpButtons> createState() => _SignUpButtonsState();
// }

// class _SignUpButtonsState extends State<SignUpButtons> {
//   bool isPrimaryPreloading = false;
//   bool isTransparentPreloading = false;

//   Future<void> Function() _viewAccount(
//     BuildContext context,
//     SplashViewModel viewmodel,
//   ) {
//     return () async {
//       unawaited(
//         Analytics.track(
//           eventName: AnalyticsEvents.viewAccount,
//         ),
//       );
//       await context.router.push(
//         const ProfileScreen(),
//       );
//     };
//   }

//   Future<void> Function() _signUpNewAccountOnWaitlist(
//     BuildContext context,
//     SplashViewModel viewmodel,
//   ) {
//     return () async {
//       // if (viewmodel.surveyCompleted) {
//       //   if (context.router.canPop()) {
//       //     context.router.popUntilRoot();
//       //   }
//       //   await context.router.replace(
//       //     WaitingListFunnelScreen(
//       //       surveyCompleted: true,
//       //     ),
//       //   );
//       // } else {
//       //   await context.router.replace(
//       //     WaitingListFunnelScreen(
//       //       surveyCompleted: false,
//       //     ),
//       //   );
//       // }
//       if (VegiConstants.showWaitingListFunnel) {
//         await rootRouter.replace(const WaitingListFunnelScreen());
//       } else {
//         await rootRouter.replace(const MainScreen());
//       }
//     };
//   }

//   Future<void> Function() _createAccount(
//     BuildContext context,
//     SplashViewModel viewmodel,
//   ) {
//     return () async {
//       if (isPrimaryPreloading) {
//         return;
//       }
//       setState(() {
//         isPrimaryPreloading = true;
//       });
//       await viewmodel.initFuse();
//     };
//   }

//   Future<void> Function() _resetSurvey(
//     BuildContext context,
//     SplashViewModel viewmodel,
//   ) {
//     return () async {
//       viewmodel.resetSurveyCompleted();
//       await rootRouter.replace(
//         const WaitingListFunnelScreen(),
//       );
//     };
//   }

//   Future<void> Function() _reLogin(
//     BuildContext context,
//     SplashViewModel viewmodel,
//   ) {
//     return () async {
//       await viewmodel.initFuse();
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, SplashViewModel>(
//       distinct: true,
//       converter: SplashViewModel.fromStore,
//       // onWillChange: (previousViewModel, newViewModel) async {
//       //   if (isPrimaryPreloading) {
//       //     return;
//       //   }
//       //   if (newViewModel.fuseAuthenticationStatus ==
//       //           FuseAuthenticationStatus.authenticated &&
//       //       previousViewModel?.fuseAuthenticationStatus !=
//       //           FuseAuthenticationStatus.authenticated) {
//       //     setState(() {
//       //       isPrimaryPreloading = true;
//       //     });
//       //     await rootRouter.push(const SignUpScreen()); // todo see TODO on splash viewmodel
//       //     return;
//       //   }
//       //   final checked = checkAuth(
//       //     oldViewModel: previousViewModel,
//       //     newViewModel: newViewModel,
//       //     routerContext: context,
//       //   );
//       //   await checked.runNavigationIfNeeded();
//       // },
//       onInit: (store) {
//         store.dispatch(fetchSurveyQuestions());
//         if (store.state.userState.accountDetailsExist) {
//           store.dispatch(getVegiWalletAccountDetails());
//           // ..dispatch(ReLogin());
//         }
//       },
//       builder: (_, viewmodel) {
//         return Stack(
//           children: [
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     flex: 6,
//                     child: Image.asset(
//                       'assets/images/Vegi-Logo-horizontal.png',
//                       width: 350,
//                       height: 250,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 150,
//                     child: Text(
//                       Labels.signupScreenTitle(
//                         isWhiteListedAccount: viewmodel.isWhiteListedAccount,
//                       ),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 80,
//                       ),
//                     ),
//                   ),
//                   if (viewmodel.surveyCompleted)
//                     SizedBox(
//                       height: 64,
//                       child: Text(
//                         Labels.signupScreenSubTitle(
//                           isWhiteListedAccount: viewmodel.isWhiteListedAccount,
//                         ),
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 16,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   Flexible(
//                     flex: 3,
//                     child: Column(
//                       children: [
//                         if (viewmodel.isLoggedIn) ...[
//                           SignUpButton(
//                             buttonText: Labels.signupButtonLabelViewAccount,
//                             onPressed: _viewAccount(
//                               context,
//                               viewmodel,
//                             ),
//                           ),
//                           if (viewmodel.isWhiteListedAccount)
//                             SignUpButton(
//                               buttonText:
//                                   Labels.signupButtonLabelReAuthenticate,
//                               onPressed: _reLogin(
//                                 context,
//                                 viewmodel,
//                               ),
//                             ),
//                         ],
//                         if (viewmodel.isLoggedOut) ...[
//                           if (viewmodel.surveyCompleted)
//                             SignUpButton(
//                               buttonText: Labels.signupButtonLabelResetSurvey,
//                               onPressed: _resetSurvey(
//                                 context,
//                                 viewmodel,
//                               ),
//                             )
//                           else
//                             SignUpButton(
//                               buttonText:
//                                   Labels.signupButtonLabelSignUp(context),
//                               onPressed: _signUpNewAccountOnWaitlist(
//                                 context,
//                                 viewmodel,
//                               ),
//                             ),
//                           if (viewmodel.surveyCompleted &&
//                               !viewmodel.accountDetailsExist)
//                             SignUpButton(
//                               buttonText: Labels.signupButtonLabelCreateAccount,
//                               onPressed: _createAccount(
//                                 context,
//                                 viewmodel,
//                               ),
//                             ),
//                           if (viewmodel.isWhiteListedAccount)
//                             SignUpButton(
//                               buttonText:
//                                   Labels.signupButtonLabelLogin(context),
//                               onPressed: _reLogin(
//                                 context,
//                                 viewmodel,
//                               ),
//                             ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
