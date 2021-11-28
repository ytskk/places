// For test purposes only
import 'package:flutter/material.dart';

// Widget for testings UI
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              height: 500,
              width: 200,
              color: Colors.red,
            ),
            Positioned.fill(
              left: -50,
              child: Container(
                margin: EdgeInsets.all(16),
                height: 400,
                width: 100,
                color: Colors.green,
              ),
            ),
            Container(
              height: 200,
              width: 50,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
