import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/services.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    Key? key,
    this.fontSize = 20,
    this.onPressedDisabled,
    this.width = 255.0,
    this.height = 50.0,
    this.preload = false,
    this.disabled = false,
    this.buttonColor,
    this.padding,
    this.margin,
  }) : super(key: key);
  final GestureTapCallback onPressed;
  final GestureTapCallback? onPressedDisabled;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final bool disabled;
  final double fontSize;
  final Color? buttonColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: buttonColor == null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: disabled
                    ? [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.secondary
                      ]
                    : [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary,
                      ],
              )
            : null,
        color: buttonColor,
        borderRadius: const BorderRadius.all(Radius.circular(11)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled
              ? onPressedDisabled?.call
              : logAndPipe(
                  onPressed,
                  funcName: 'onPressed',
                  className: "$this",
                  logMessage:
                      'onPressed handler called for button on ${rootRouter.current.name}',
                ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          highlightColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          splashColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
          child: Center(
            child: !preload
                ? AutoSizeText(
                    label,
                    style: TextStyle(
                      color: disabled ? const Color(0xFF797979) : Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                  )
                : Container(
                    width: 21,
                    height: 21,
                    margin: const EdgeInsets.only(left: 28, right: 28),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
