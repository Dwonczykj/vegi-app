import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiAvatar.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/onboard.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class UserNameScreen extends StatelessWidget {
  UserNameScreen({Key? key}) : super(key: key);

  final TextEditingController displayNameController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    const avatarSquareSize = 70.0;
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: StoreConnector<AppState, VerifyOnboardViewModel>(
        distinct: true,
        converter: VerifyOnboardViewModel.fromStore,
        // onInit: (store) => store.dispatch(setRandomUserAvatarIfNone()),
        builder: (_, viewmodel) {
          return Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        const VegiAvatar(
                          isEditable: true,
                          avatarSquareSize: avatarSquareSize,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          I10n.of(context).pickup_display_name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 255,
                          color: Theme.of(context).canvasColor,
                          child: TextFormField(
                            controller: displayNameController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            autofocus: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                              fillColor: Theme.of(context).canvasColor,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Center(
                    child: PrimaryButton(
                      label: I10n.of(context).next_button,
                      onPressed: () {
                        if (displayNameController.text.isNotEmpty) {
                          viewmodel.setDisplayName(
                            displayName:
                                displayNameController.text.capitalize(),
                          );
                          _nextOnBoardingScreen(
                            viewmodel,
                            context,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> _nextOnBoardingScreen(
    VerifyOnboardViewModel viewModel,
    BuildContext context,
  ) async {
    await onBoardStrategy.nextOnboardingPage();
  }

  void _showSourceImagePicker(
    BuildContext context,
    void Function(ImageSource source) callback,
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
                  title: Text(I10n.of(context).camera),
                  onTap: () {
                    callback(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(I10n.of(context).gallery),
                  onTap: () {
                    callback(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Refresh'),
                  onTap: () async {
                    final vegiUserId = StoreProvider.of<AppState>(context)
                        .state
                        .userState
                        .vegiUserId;
                    if (vegiUserId != null) {
                      StoreProvider.of<AppState>(context).dispatch(
                        setRandomUserAvatar(vegiUserId: vegiUserId),
                      );
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      await showErrorSnack(
                        context: context,
                        title:
                            'Lost connection to vegi, please try again later.',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
