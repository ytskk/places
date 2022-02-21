import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/ui/components/image/load_network_image.dart';

Widget NetworkImageBox(
  imageUrl, {
  double width = double.infinity,
  double height = 96,
  required BuildContext context,
}) {
  // check is dark mode to dim images TEMP
  bool isDark = Theme.of(context).backgroundColor == AppColorsDark().background;
  Opacity imageOpacity = Opacity(
    opacity: isDark ? 0.6 : 0.5,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff252849),
            Color.fromRGBO(59, 62, 91, 0.08),
          ],
          begin: Alignment.topCenter,
          end: isDark ? Alignment.bottomCenter : Alignment.center,
        ),
      ),
    ),
  );

  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      fit: StackFit.expand,
      children: [
        loadNetworkImage(imageUrl),
        imageOpacity,
      ],
    ),
  );
}
