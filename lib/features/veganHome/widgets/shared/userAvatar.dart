import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.avatarUrl,
    this.avatarSquareSize = 50.0,
    this.showAdminBanner = false,
    this.isUpdating = false,
  }) : super(key: key);

  final String avatarUrl;
  final double avatarSquareSize;
  final bool showAdminBanner;
  final bool isUpdating;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        50,
      ), //removes excess shadow under the border that isnt clipped under the clipRRect below this one.
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: avatarSquareSize,
              height: avatarSquareSize,
              imageUrl: avatarUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(
                backgroundImage: AssetImage('assets/images/anom.png'),
                radius: 30,
              ),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (showAdminBanner)
            Positioned(
              right: -(avatarSquareSize / 4.0),
              top: -(avatarSquareSize / 4.0),
              child: Container(
                height: avatarSquareSize * .5,
                width: avatarSquareSize * .5,
                alignment: Alignment.topRight,
                child: Banner(
                  message: 'Admin',
                  textDirection: TextDirection.ltr,
                  location: BannerLocation.topEnd,
                  color: themeLightShade1000,
                  textStyle: TextStyle(
                    fontFamily: Fonts.fatFace,
                    fontSize: (avatarSquareSize / 5.0),
                  ),
                ),
              ),
            ),
          if (isUpdating)
            // Center(child: CircularProgressIndicator()),
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 1.0,
                  sigmaY: 1.0,
                ),
                child: Center(
                  child:
                      CircularProgressIndicator(), // replace your loading widget
                ),
              ),
            )
        ],
      ),
    );
  }
}
