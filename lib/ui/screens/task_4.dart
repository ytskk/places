// For test purposes only
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_strings.dart';

// Widget for UI testings
class Test extends StatelessWidget {
  /// Testing some elements.
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: ExactAssetImage('assets/images/castell.jpg'),
          ),
        ),
      ),
    );
  }
}
