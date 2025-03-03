import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required this.child, Key? key,
    this.height = 350.0,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle overlayStyle =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      sized: false,
      child: ColoredBox(
        color: Theme.of(context).canvasColor,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
