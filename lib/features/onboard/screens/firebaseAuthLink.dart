import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/analytics_props.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/arrowButton.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/emptyStatePage.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/onboarding/firebaseAuthLinkViewModel.dart';
import 'package:vegan_liverpool/redux/viewsmodels/onboarding/verifyEmailLinkViewModel.dart';
import 'package:vegan_liverpool/redux/viewsmodels/waitingListFunnel/waitingListPositionInQueueViewModel.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class FirebaseAuthLinkPage extends StatelessWidget {
  const FirebaseAuthLinkPage({
    this.recaptchaToken,
    this.deepLinkId,
    Key? key,
  }) : super(key: key);

  final String? recaptchaToken;
  final String? deepLinkId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseAuthLinkViewModel>(
      converter: FirebaseAuthLinkViewModel.fromStore,
      distinct: true,
      onWillChange: (oldViewModel, newViewModel) {
        _route(newViewModel);
      },
      builder: (context, viewModel) {
        return FutureBuilder<void>(
          future: viewModel.handleFirebaseAuthReCaptchaWebHook(
            recaptchaToken: recaptchaToken,
            deepLinkId: deepLinkId,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              rootRouter.push(
                const MainScreen(),
              ); // dont replace as keep nav state here
            }
            return const MyScaffold(
              title: 'Authentication',
              body: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Future<void> _route(FirebaseAuthLinkViewModel viewModel) async {
    final success = viewModel.isLoggedIn;
    logFunctionCall(
      className: 'FirebaseAuthLinkPage',
      funcName: '_route',
      logMessage: 'routing with success = [$success]',
    );
    if (viewModel.vegiAuthenticationStatus == VegiAuthenticationStatus.failed) {
      log.error('vegi login failed. Investigate why...');
    }
    final store = await reduxStore;
    if (store.state.onboardingState.signupIsInFlux) {
      return;
    }
    if (success) {
      await onBoardStrategy.nextOnboardingPage();
    }
  }
}
