import 'package:flutter/material.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/task_4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
      ),
      home: SightListScreen(),
      // home: Test(),
    );
  }
}
