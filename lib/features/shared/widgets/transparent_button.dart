import 'package:flutter/material.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/services.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.onPressed, required this.label, Key? key,
    this.fontSize = 18,
    this.width = 21.0,
    this.height = 21.0,
    this.preload = false,
    this.textColor = Colors.black87,
  }) : super(key: key);

  final void Function() onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: logAndPipe(
          onPressed,
          funcName: 'onPressed',
          className: "$this",
          logMessage:
              'onPressed handler called for $this on ${rootRouter.current.name}',
        ),
        child: !preload
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                    color: textColor,
                  ),
                ),
              )
            : Container(
                width: width,
                height: height,
                margin: const EdgeInsets.only(left: 28, right: 28),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
      ),
    );
  }
}
