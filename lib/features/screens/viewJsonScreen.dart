import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/screens/app_log_list_view.dart';
import 'package:vegan_liverpool/features/shared/widgets/jsonView.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shareDialog.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class ViewJsonScreen extends StatelessWidget {
  const ViewJsonScreen({
    required this.data,
    Key? key,
  }) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppLogListViewModel>(
      converter: AppLogListViewModel.fromStore,
      distinct: true,
      builder: (context, viewModel) {
        return MyScaffold(
          title: 'JSON Viewer',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.purple,
              ),
              onPressed: () => showDialog<Widget>(
                context: context,
                builder: (context) => ShareDialog(
                  data: jsonEncode(data),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: JsonViewer(
              json: data,
              level: 0,
            ),
          ),
        );
      },
    );
  }
}
