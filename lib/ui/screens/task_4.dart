// For test purposes only
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double basicSize = 50;

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.yellow,
          width: double.infinity,
          height: basicSize,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Text span',
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Nested',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
