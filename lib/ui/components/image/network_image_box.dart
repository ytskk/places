import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/ui/components/image/load_network_image.dart';

class NetworkImageBox extends StatelessWidget {
  final String imageUrl;

  final double width;
  final double height;

  const NetworkImageBox(
    String this.imageUrl, {
    Key? key,
    double this.width = double.infinity,
    double this.height = 96,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check is dark mode to dim images TEMP
    bool isDark =
        Theme.of(context).backgroundColor == AppColorsDark().background;
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
          NetworkImageWidget(imageUrl: imageUrl),
          imageOpacity,
        ],
      ),
    );
  }
}

class RoundedNetworkImageBox extends NetworkImageBox {
  final String imageUrl;
  final double borderRadius;

  const RoundedNetworkImageBox({
    Key? key,
    required String this.imageUrl,
    double this.borderRadius = 12,
  }) : super(imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(borderRadius),
      child: NetworkImageBox(
        imageUrl,
        width: 56,
        height: 56,
      ),
    );
  }
}
