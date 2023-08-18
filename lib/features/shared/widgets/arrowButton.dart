import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/services.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    required this.onTap,
    this.tooltip = '',
    this.iconSize,
    Key? key,
  }) : super(key: key);

  final void Function() onTap;
  final String tooltip;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.east),
      color: Theme.of(context).primaryColor,
      highlightColor: themeShade850,
      tooltip: tooltip,
      onPressed: logAndPipe(
        onTap,
        funcName: 'onTap',
        className: "$this",
        logMessage:
            'onTap handler called for button on ${rootRouter.current.name}',
      ),
      iconSize: iconSize,
    );
  }
}
