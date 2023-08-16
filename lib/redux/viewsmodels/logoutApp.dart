import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/logoutDialog.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

@RoutePage()
class LogoutApp extends StatefulWidget {
  const LogoutApp({Key? key}) : super(key: key);

  @override
  State<LogoutApp> createState() => _LogoutAppState();
}

class _LogoutAppState extends State<LogoutApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await showDialog<String>(
      //   context: context,
      //   builder: (BuildContext context) => new AlertDialog(
      //     title: new Text("title"),
      //     content: new Text("Message"),
      //     actions: <Widget>[
      //       new FlatButton(
      //         child: new Text("OK"),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   ),
      // );
      await showDialog<Widget>(
        context: context,
        builder: (context) => const LogoutDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LogOutRouteViewModel>(
      converter: LogOutRouteViewModel.fromStore,
      builder: (context, viewModel) {
        return LoadingScaffold;
      },
    );
  }
}

class LogOutRouteViewModel extends Equatable {
  const LogOutRouteViewModel(
      // {
      // required this.refreshOrders,
      // }
      );

  factory LogOutRouteViewModel.fromStore(Store<AppState> store) {
    return const LogOutRouteViewModel(
        // refreshOrders: () {
        //   store.dispatch(
        //     ResetAppState(),
        //   );
        // },
        );
  }

  // final void Function() refreshOrders;

  @override
  List<Object?> get props => [];
}
