import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCardPhoto(imageUrl) {
  return SizedBox(
    height: 96,
    width: double.infinity,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
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
                color: Colors.blue,
              ),
            );
          },
        ),
        Opacity(
          opacity: 0.4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff252849),
                  Color.fromRGBO(59, 62, 91, 0.08),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
