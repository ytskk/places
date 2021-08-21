import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySecondWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  var _rerendiringCount = 0;

  var _rerendedingCount2 = 0;

  @override
  void didUpdateWidget(covariant MySecondWidget oldWidget) {
    _rerendedingCount2 += 1;
    print(_rerendedingCount2);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _rerendiringCount += 1;
    print('statful rerenderings: $_rerendiringCount');
    return Container(
        child: Center(
            child: Text(
      'Hello!',
      style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300),
    )));
  }
}

class MyFirstWidget extends StatelessWidget {
  MyFirstWidget({Key? key}) : super(key: key);

  var _rerendiringCount = 0;

  @override
  Widget build(BuildContext context) {
    _rerendiringCount += 1;
    print('rerendeding count: $_rerendiringCount');
    return Container(child: Center(child: Text('Hello!')));
  }
}
