import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/appLogDetailDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shareDialog.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/log_event.dart';

class AppLogListView extends StatelessWidget {
  const AppLogListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppLogListViewModel>(
      converter: AppLogListViewModel.fromStore,
      distinct: true,
      builder: (context, viewModel) {
        return MyScaffold(
          title: 'App Logs',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () => showDialog<Widget>(
                context: context,
                builder: (context) => ShareDialog(
                  data: viewModel.logsAsString,
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // to prevent scrolling of the inner ListView
              shrinkWrap:
                  true, // to let ListView decide length of the ScrollView
              itemCount: viewModel.logs.length,
              itemBuilder: (context, index) {
                final item = viewModel.logs[viewModel.logs.length - index - 1];
                return ListTile(
                  title: Text(item.message),
                  leading: Text(item.timestamp.formatToHHmmss),
                  onTap: withHelloWorld(() => showDialog<Widget>(
                    context: context,
                    builder: (context) => AppLogDetailDialog(log: item),
                  ),),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AppLogListViewModel extends Equatable {
  const AppLogListViewModel({
    required this.logs,
  });

  factory AppLogListViewModel.fromStore(Store<AppState> store) {
    return AppLogListViewModel(
      logs: store.state.appLogState.logs,
    );
  }

  final List<LogEvent> logs;

  String get logsAsString => logs.map((e) => e.toString()).join('\n');

  @override
  List<Object?> get props => [
        logs,
      ];
}
