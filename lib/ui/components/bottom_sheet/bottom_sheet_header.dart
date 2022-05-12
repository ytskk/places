import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';

class BottomSheetHeader extends StatelessWidget {
  /// Adds bottom sheet indicator and close button.
  ///
  /// Stacks [child] and indicator with close button with linear gradient.
  const BottomSheetHeader({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).orientation == Orientation.portrait
            ? 46.0
            : 24.0,
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(smallBorderRadius),
          topRight: Radius.circular(smallBorderRadius),
        ),
        child: Stack(
          children: [
            child,
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(largeBorderRadius),
                            ),
                          ),
                          child: SizedBox(
                            height: 4,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    iconSize: 40,
                    icon: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
