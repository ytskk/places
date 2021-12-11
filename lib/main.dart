import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/task_4.dart';

import 'ui/screens/sight_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surf places app',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
      ),
      // home: SightListScreen(),
      home: SightDetails(mocks[0]),
      // home: Test(),
    );
  }
}
