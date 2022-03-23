import 'package:flutter/cupertino.dart';
import 'package:places/ui/screens/res/themes.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;

  const NetworkImageWidget({
    Key? key,
    required String this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (
        context,
        child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) return child;

        return Center(
          child: CupertinoActivityIndicator.partiallyRevealed(
            progress: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : 1,
          ),
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
