import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';

class VegiAvatarViewModel extends Equatable {
  const VegiAvatarViewModel({
    required this.editAvatar,
    required this.avatarUrl,
    required this.avatarTempFilePath,
    required this.httpRequestIsInFlux,
    required this.isLoggedIn,
    required this.userIsVegiAdmin,
  });

  factory VegiAvatarViewModel.fromStore(Store<AppState> store) {
    return VegiAvatarViewModel(
      avatarUrl: store.state.userState.avatarUrl,
      avatarTempFilePath: store.state.userState.avatarTempFilePath,
      httpRequestIsInFlux: store.state.homePageState.isLoadingHttpRequest,
      isLoggedIn: !store.state.userState.hasNotOnboarded,
      userIsVegiAdmin: !store.state.userState.isVegiSuperAdmin,
      editAvatar: (
        source, {
        ProgressCallback? progressCallback,
        void Function()? onSuccess,
        void Function(String errStr)? onError,
      }) {
        store
          ..dispatch(
            SetIsLoadingHttpRequest(
              isLoading: true,
            ),
          )
          ..dispatch(
            updateUserAvatarCall(
              source,
              progressCallback: progressCallback,
              onSuccess: onSuccess,
              onError: onError,
            ),
          );
      },
    );
  }

  final String avatarUrl;
  final String avatarTempFilePath;
  final bool isLoggedIn;
  final bool userIsVegiAdmin;
  final bool httpRequestIsInFlux;

  final void Function(
    ImageSource source, {
    ProgressCallback? progressCallback,
    void Function()? onSuccess,
    void Function(String errStr)? onError,
  }) editAvatar;

  @override
  List<Object?> get props => [
        avatarUrl,
        avatarTempFilePath,
        httpRequestIsInFlux,
        isLoggedIn,
        userIsVegiAdmin,
      ];
}
