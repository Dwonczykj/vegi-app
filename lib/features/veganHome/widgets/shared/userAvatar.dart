import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.avatarUrl,
    Key? key,
    this.avatarSquareSize = 40.0,
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
          Container(
            // decoration: BoxDecoration(
            //     color: Colors.transparent,
            //     borderRadius: const BorderRadius.only(
            //       topLeft: Radius.circular(16),
            //       topRight: Radius.circular(16),
            //     ),
            //     border: Border.all(
            //       color: Colors.red,
            //       width: 2,
            //       style: BorderStyle.solid,
            //     )),
            padding: EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                // decoration: BoxDecoration(
                //   color: Colors.yellow,
                //   borderRadius: const BorderRadius.only(
                //     topLeft: Radius.circular(16),
                //     topRight: Radius.circular(16),
                //   ),
                // ),
                child: FutureBuilder<Size>(
                  future: calculateImageDimensionFromUrl(
                    imageUrl: avatarUrl,
                  ),
                  builder: (context, snapshot) {
                    return CachedNetworkImage(
                      width: avatarSquareSize,
                      height: avatarSquareSize,
                      imageUrl: avatarUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/anom.png'),
                        radius: 30,
                      ),
                      imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
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
                    fontSize: avatarSquareSize / 5.0,
                  ),
                ),
              ),
            ),
          if (isUpdating)
            // Center(child: CircularProgressIndicator()),
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: const Center(
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
