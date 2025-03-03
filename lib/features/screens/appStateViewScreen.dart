import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/screens/app_log_list_view.dart';
import 'package:vegan_liverpool/features/shared/widgets/jsonView.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shareDialog.dart';
import 'package:vegan_liverpool/models/app_state.dart';

@RoutePage()
class AppStateViewScreen extends StatelessWidget {
  const AppStateViewScreen({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppLogListViewModel>(
      converter: AppLogListViewModel.fromStore,
      distinct: true,
      builder: (context, viewModel) {
        return MyScaffold(
          title: 'App state viewer',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.purple,
              ),
              onPressed: () => showDialog<Widget>(
                context: context,
                builder: (context) => ShareDialog(
                  data: viewModel.appStateAsString,
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: JsonViewer(
              json: viewModel.appStateJson,
              level: 0,
            ),
          ),
        );
      },
    );
  }
}

