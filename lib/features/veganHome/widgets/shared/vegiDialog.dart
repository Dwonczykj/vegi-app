import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/utils/analytics.dart';

class VegiDialog<ViewModel> extends StatefulWidget {
  const VegiDialog({
    required this.child, required this.storeConverter, Key? key,
    this.onWillChange,
    this.actions,
  }) : super(key: key);

  final Widget child;
  final ViewModel Function(Store<AppState> store) storeConverter;
  final ViewModel Function(
    ViewModel? oldViewModel,
    ViewModel newViewModel,
  )? onWillChange;
  final List<Widget>? actions;
  @override
  State<VegiDialog<ViewModel>> createState() => _VegiDialogState();
}

class _VegiDialogState<ViewModel> extends State<VegiDialog<ViewModel>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller
      ..addListener(() {
        setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: widget.storeConverter,
      distinct: true,
      onWillChange: widget.onWillChange ?? (oldVm, newVm) {},
      builder: (_, viewmodel) {
        return ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              decoration: const BoxDecoration(
                color: themeShade100,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(8),
              child: widget.child,
            ),
            actions: widget.actions,
          ),
        );
      },
    );
  }
}
