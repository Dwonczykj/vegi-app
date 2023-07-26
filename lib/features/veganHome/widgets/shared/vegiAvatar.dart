import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/userAvatar.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/vegiAvatarViewModel.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class VegiAvatar extends StatelessWidget {
  const VegiAvatar({
    Key? key,
    required this.isEditable,
    this.avatarSquareSize = 50.0,
    this.showAdminBanner = false,
  }) : super(key: key);

  final double avatarSquareSize;
  final bool isEditable;
  final bool showAdminBanner;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VegiAvatarViewModel>(
      distinct: true,
      converter: VegiAvatarViewModel.fromStore,
      builder: (context, viewmodel) {
        if (!isEditable) {
          if (viewmodel.avatarUrl.isNotEmpty) {
            return UserAvatar(
              avatarUrl: viewmodel.avatarUrl,
              avatarSquareSize: avatarSquareSize,
              showAdminBanner: viewmodel.userIsVegiAdmin,
            );
          } else if (viewmodel.avatarTempFilePath.isNotEmpty) {
            return Stack(
              children: [
                SizedBox(
                  height: avatarSquareSize,
                  width: avatarSquareSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ColoredBox(
                      color: Colors.grey.shade400,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(viewmodel.avatarTempFilePath),
                            // radius: 23,
                            radius: avatarSquareSize / 2.0 +
                                (avatarSquareSize * 0.1),
                          ),
                          if (viewmodel.userIsVegiAdmin)
                            Positioned(
                              right: -(avatarSquareSize / 4.0),
                              top: -(avatarSquareSize / 4.0),
                              child: Container(
                                height: avatarSquareSize * .5,
                                width: avatarSquareSize * .5,
                                alignment: Alignment.topRight,
                                child: Banner(
                                  message: 'Admin',
                                  textDirection: TextDirection.ltr,
                                  location: BannerLocation.topEnd,
                                  color: themeLightShade1000,
                                  textStyle: TextStyle(
                                    fontFamily: Fonts.fatFace,
                                    fontSize: (avatarSquareSize / 5.0),
                                  ),
                                ),
                              ),
                            ),
                          if (viewmodel.isLoggedIn && isEditable)
                            Positioned.directional(
                              textDirection: TextDirection.ltr,
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                alignment: Alignment.center,
                                color: Theme.of(context).colorScheme.onSurface,
                                child: Text(
                                  I10n.of(context).edit,
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return CircleAvatar(
              backgroundImage: const AssetImage(ImagePaths.anomAvatar),
              // radius: 23,
              radius: avatarSquareSize / 2.0 + (avatarSquareSize * 0.1),
            );
          }
        }
        return GestureDetector(
          onTap: () => viewmodel.isLoggedIn
              ? _showSourceImagePicker(
                  context,
                  (source) => viewmodel.editAvatar(
                    source,
                    onError: (errStr) async {
                      await showErrorSnack(
                        context: context,
                        title: Messages.operationFailed,
                        message: '$errStr',
                      );
                    },
                  ),
                )
              : null,
          child: viewmodel.avatarUrl.isNotEmpty
              ? SizedBox(
                  height: avatarSquareSize,
                  width: avatarSquareSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ColoredBox(
                      color: Colors.grey.shade400,
                      child: Stack(
                        children: [
                          UserAvatar(
                            avatarUrl: viewmodel.avatarUrl,
                            avatarSquareSize: avatarSquareSize,
                            isUpdating: viewmodel.httpRequestIsInFlux,
                          ),
                          if (viewmodel.isLoggedIn)
                            Positioned.directional(
                              textDirection: TextDirection.ltr,
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                alignment: Alignment.center,
                                color: Theme.of(context).colorScheme.onSurface,
                                child: Text(
                                  I10n.of(context).edit,
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )
              : viewmodel.avatarTempFilePath.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: avatarSquareSize,
                            width: avatarSquareSize,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ColoredBox(
                                color: Colors.grey.shade400,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          viewmodel.avatarTempFilePath),
                                      // radius: 23,
                                      radius: avatarSquareSize / 2.0 +
                                          (avatarSquareSize * 0.1),
                                    ),
                                    if (viewmodel.userIsVegiAdmin)
                                      Positioned(
                                        right: -(avatarSquareSize / 4.0),
                                        top: -(avatarSquareSize / 4.0),
                                        child: Container(
                                          height: avatarSquareSize * .5,
                                          width: avatarSquareSize * .5,
                                          alignment: Alignment.topRight,
                                          child: Banner(
                                            message: 'Admin',
                                            textDirection: TextDirection.ltr,
                                            location: BannerLocation.topEnd,
                                            color: themeLightShade1000,
                                            textStyle: TextStyle(
                                              fontFamily: Fonts.fatFace,
                                              fontSize:
                                                  (avatarSquareSize / 5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (viewmodel.isLoggedIn && isEditable)
                                      Positioned.directional(
                                        textDirection: TextDirection.ltr,
                                        bottom: 0,
                                        start: 0,
                                        end: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          alignment: Alignment.center,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          child: Text(
                                            I10n.of(context).edit,
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).canvasColor,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: isEditable
                          ? SvgPicture.asset(
                              ImagePaths.avatarPlaceholder,
                              width: 95,
                              height: avatarSquareSize,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  const AssetImage(ImagePaths.anomAvatar),
                              // radius: 23,
                              radius: avatarSquareSize / 2.0 +
                                  (avatarSquareSize * 0.1),
                            ),
                    ),
        );
      },
    );
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
                    final vegiAccountId = StoreProvider.of<AppState>(context)
                        .state
                        .userState
                        .vegiAccountId;
                    if (vegiAccountId != null) {
                      (await reduxStore).dispatch(
                        setRandomUserAvatar(vegiAccountId: vegiAccountId),
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
