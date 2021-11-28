import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: double.infinity,
          title: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
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
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: mocks.length,
        itemBuilder: (context, index) {
          return SightCard(mocks[index]);
        },
      ),
    );
  }
}
