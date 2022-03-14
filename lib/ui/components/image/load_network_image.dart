import 'package:flutter/cupertino.dart';
import 'package:places/ui/screens/res/themes.dart';

Image loadNetworkImage(imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
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
