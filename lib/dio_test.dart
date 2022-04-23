import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/data/basic_configuration_test.dart';

class DioTestScreen extends StatefulWidget {
  const DioTestScreen({Key? key}) : super(key: key);

  @override
  State<DioTestScreen> createState() => _DioTestScreenState();
}

class _DioTestScreenState extends State<DioTestScreen> {
  @override
  void initState() {
    super.initState();
    parseUsers();
  }

  Future<void> parseUsers() async {
    final response = await getUsers();

    print('response in ui: $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dio test'),
      ),
    );
  }
}
