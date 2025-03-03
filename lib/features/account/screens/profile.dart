import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/delivery_address/delivery_address_selector_button.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/deleteAccountDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiAvatar.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/admin/vegiConfigDTO.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/profile.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/format.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? displayName;
  String? userEmail;
  num? imageUploadPercent = 100;
  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      onInit: (store) => store.dispatch(setRandomUserAvatarIfNone()),
      onDispose: (store) {
        if (displayName != null) {
          if (store.state.userState.displayName != displayName) {
            final viewmodel = ProfileViewModel.fromStore(store);
            viewmodel.updateDisplayName(displayName!);
          }
        }
        if (userEmail != null) {
          if (store.state.userState.email != userEmail) {
            final viewmodel = ProfileViewModel.fromStore(store);
            viewmodel.updateUserEmail(
              userEmail!,
              (errStr) {
                showErrorSnack(
                  context: context,
                  title: Messages.connectionError,
                  message: errStr,
                );
              },
            );
          }
        }
      },
      builder: (_, viewmodel) {
        const avatarSquareSize = 70.0;
        return MyScaffold(
          title: I10n.of(context).account,
          body: InkWell(
            focusColor: Theme.of(context).canvasColor,
            highlightColor: Theme.of(context).canvasColor,
            onTap: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            },
            child: Material(
              color: Theme.of(context).canvasColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const VegiAvatar(
                                isEditable: true,
                                avatarSquareSize: avatarSquareSize,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                viewmodel.displayName,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        if (viewmodel.isLoggedIn &&
                            viewmodel.phone.isNotEmpty) ...[
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                I10n.of(context).name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              initialValue: viewmodel.displayName,
                              keyboardType: TextInputType.text,
                              cursorColor: const Color(0xFFC6C6C6),
                              onChanged: (value) => displayName = value,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                fillColor: Theme.of(context).canvasColor,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              initialValue: viewmodel.email,
                              keyboardType: TextInputType.text,
                              cursorColor: const Color(0xFFC6C6C6),
                              onChanged: (value) => userEmail = value,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                fillColor: Theme.of(context).canvasColor,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          _buildGroup(
                            '${I10n.of(context).phoneNumber}${viewmodel.isSuperAdmin ? " [belongs to admin]" : ""}',
                            Text(
                              viewmodel.phone,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            // leading: const Icon(Icons.lock),
                            title: const Text('Security'),
                            trailing: const Icon(Icons.lock),
                            subtitle: Text(
                              viewmodel.biometricAuthType.name
                                  .capitalizeWords(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              Analytics.track(
                                eventName: AnalyticsEvents.securityScreen,
                              );
                              context.router.push(const ChooseSecurityOption());
                            },
                          ),
                          if (viewmodel.isVerified) ...[
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Location',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            ColoredBox(
                              color: Colors.transparent,
                              child: CupertinoFormRow(
                                prefix: Row(
                                  children: <Widget>[
                                    Icon(
                                      // Wifi icon is updated based on switch value.
                                      viewmodel.useLiveLocation
                                          ? Icons.location_on
                                          : Icons.location_off,
                                      color: viewmodel.useLiveLocation
                                          ? CupertinoColors.systemBlue
                                          : CupertinoColors.systemRed,
                                    ),
                                    const SizedBox(width: 10),
                                    if (viewmodel.useLiveLocation)
                                      const Text('Location enabled')
                                    else
                                      const Text('Location disabled')
                                  ],
                                ),
                                helper: viewmodel.useLiveLocation
                                    ? Text(
                                        'Using location to see nearest vendors to you!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    : Text(
                                        'Enable location to see nearest vendors to you!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                child: CupertinoSwitch(
                                  // This bool value toggles the switch.
                                  value: viewmodel.useLiveLocation,
                                  thumbColor: viewmodel.useLiveLocation
                                      ? themeShade600
                                      : themeShade600.withOpacity(0.5),
                                  trackColor: viewmodel.useLiveLocation
                                      ? CupertinoColors.systemGrey
                                          .withOpacity(0.95)
                                      : CupertinoColors.systemGrey
                                          .withOpacity(0.15),
                                  activeColor: themeShade300.withOpacity(0.10),
                                  onChanged: (bool? value) {
                                    // This is called when the user toggles the switch
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() {
                                      viewmodel.useLocationServices(value);
                                      viewmodel.refreshVendors();
                                    });
                                    setState(() {
                                      Analytics.track(
                                        eventName: value
                                            ? AnalyticsEvents
                                                .enableLocationServices
                                            : AnalyticsEvents
                                                .disableLocationServices,
                                        properties: {'screen': 'home'},
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ],
                        const Divider(),
                        _buildGroup(
                          I10n.of(context).wallet_address,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Formatter.formatEthAddress(
                                  viewmodel.walletAddress,
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                focusColor: Theme.of(context).canvasColor,
                                highlightColor: Theme.of(context).canvasColor,
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: viewmodel.walletAddress,
                                    ),
                                  );
                                  showCopiedFlushbar(context);
                                },
                                child: Icon(
                                  const FaIcon(FontAwesomeIcons.copy).icon,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        _buildGroup(
                          'Seed Phrase',
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  viewmodel.seedPhrase.toString().substring(
                                        1,
                                        viewmodel.seedPhrase.toString().length -
                                            1,
                                      ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              InkWell(
                                focusColor: Theme.of(context).canvasColor,
                                highlightColor: Theme.of(context).canvasColor,
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: viewmodel.seedPhrase
                                          .toString()
                                          .substring(
                                            1,
                                            viewmodel.seedPhrase
                                                    .toString()
                                                    .length -
                                                1,
                                          ),
                                    ),
                                  );
                                  showCopiedFlushbar(context);
                                },
                                child: Icon(
                                  const FaIcon(FontAwesomeIcons.copy).icon,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        if (viewmodel.isSuperAdmin ||
                            DebugHelpers.inDebugMode) ...[
                          FutureBuilder<VegiConfigDTO?>(
                            future: viewmodel.getConfigDetails(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              return Column(
                                children: [
                                  const Divider(),
                                  ListTile(
                                    title: const Text('Database'),
                                    subtitle: Text(
                                      snapshot.hasData
                                          ? snapshot.data!.databaseUrl
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onTap: () {
                                      // todo: implement refresh call
                                    },
                                  ),
                                  const Divider(),
                                  ListTile(
                                    title: const Text('vegi environment'),
                                    subtitle: Text(
                                      snapshot.hasData
                                          ? snapshot.data!.environment
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onTap: () {
                                      // todo: implement refresh call
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            // leading: const Icon(Icons.lock),
                            title: const Text('firebase'),
                            trailing: const Icon(FontAwesomeIcons.google),
                            subtitle: Text(
                              viewmodel.firebaseAuthenticationStatus.name
                                  .capitalizeWords(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              // todo: implement refresh call
                            },
                          ),
                          const Divider(),
                          ListTile(
                            // leading: const Icon(Icons.lock),
                            title: const Text('vegi'),
                            trailing: Image.asset(
                              ImagePaths.veganOnlyIcon,
                              width: 25,
                            ),
                            subtitle: Text(
                              viewmodel.vegiAuthenticationStatus.name
                                  .capitalizeWords(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              // todo: implement refresh call
                            },
                          ),
                          const Divider(),
                          ListTile(
                            // leading: const Icon(Icons.lock),
                            title: const Text('Fuse'),
                            trailing: Image.asset(
                              ImagePaths.fuseIconFilledGreen,
                              width: 50,
                            ),
                            subtitle: Text(
                              viewmodel.fuseAuthenticationStatus.name
                                  .capitalizeWords(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              // todo: implement refresh call
                            },
                          ),
                        ],
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        PrimaryButton(
                          label: 'Delete Account',
                          onPressed: () => showDialog<Widget>(
                            context: context,
                            builder: (context) => const DeleteAccountDialog(),
                          ),
                          buttonColor: const Color.fromARGB(255, 144, 0, 0),
                        ),
                        // const Divider(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // PrimaryButton(
                        //   label: 'Restore Wallet',
                        //   onPressed: () =>
                        //       rootRouter.push(const RestoreFromBackupScreen()),
                        //   buttonColor: themeLightShade800,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroup(String title, Widget rightWidget) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              rightWidget,
            ],
          ),
        ),
      );

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
                  // title: Text(I10n.of(context).gallery),
                  title: const Text('Camera roll'),
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
