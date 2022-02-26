import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTabDemoState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.clock),
                text: 'tab 1',
              ),
              Tab(
                text: 'tab 2',
              ),
              Tab(
                text: 'tab 3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(child: Text('data 1')),
            Center(child: Text('data 2')),
            Center(child: Text('data 3')),
          ],
        ),
      ),
    );
  }
}
