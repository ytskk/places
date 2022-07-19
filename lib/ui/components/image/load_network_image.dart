import 'package:flutter/cupertino.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/ui/screens/res/themes.dart';

class NetworkImageWidget extends StatelessWidget {
  /// Creates a widget that displays an [ImageStream] obtained from the network.
  ///
  /// Provides a progress loader - widget to display to the user while an image is still loading.
  ///
  /// If an error occurs, displays red.
  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  /// The URL from which the image will be fetched.
  final String imageUrl;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: longDuration,
          curve: brandCurve,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppThemeData.selectColor().red,
          ),
        );
      },
    );
  }
}
