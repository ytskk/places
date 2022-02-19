import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/components/image/load_network_image.dart';

Widget NetworkImageBox(
  imageUrl, {
  double width = double.infinity,
  double height = 96,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      fit: StackFit.expand,
      children: [
        loadNetworkImage(imageUrl),
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
