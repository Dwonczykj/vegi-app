import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class ResetApp extends StatelessWidget {
  const ResetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: ResetAppViewModel.fromStore,
      onInit: (store) {
        try {
          store.dispatch(
            ResetAppState(),
          );
        } on Exception catch (e, s) {
          log.error(
            'Unable to reset app FATAL - Causing app crash: $e',
            error: e,
            stackTrace: s,
          );
        }
        try {
          rootRouter.replaceAll([SplashScreen()]);
        } on Exception catch (e, s) {
          log.error(
            'Unable to reset app FATAL - Causing app crash: $e',
            error: e,
            stackTrace: s,
          );
        }
      },
      builder: (context, viewModel) {
        return LoadingScaffold;
      },
    );
  }
}

class ResetAppViewModel extends Equatable {
  const ResetAppViewModel({
    required this.refreshOrders,
  });

  factory ResetAppViewModel.fromStore(Store<AppState> store) {
    return ResetAppViewModel(
      refreshOrders: () {
        store.dispatch(
          ResetAppState(),
        );
      },
    );
  }

  final void Function() refreshOrders;

  @override
  List<Object?> get props => [];
}
