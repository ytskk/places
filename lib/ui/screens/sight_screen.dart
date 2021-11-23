import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        // Посмотрел высоту RichText в Widget Inspector
        toolbarHeight: 72,
        title: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            // Решил задать «родительский» стиль для компонентов
            style: TextStyle(
              fontSize: 32,
              height: 1.12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: 'С', style: TextStyle(color: Colors.green)),
              TextSpan(text: 'писок\n'),
              TextSpan(text: 'И', style: TextStyle(color: Colors.yellow)),
              TextSpan(text: 'нтересных мест'),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Hello'), TextField()],
      ),
    );
  }
}
