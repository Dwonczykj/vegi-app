import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VegiHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // nested routes will be rendered here
          child: AutoRouter(),
        )
      ],
    );
  }
}
