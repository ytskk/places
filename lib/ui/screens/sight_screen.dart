import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/card/sight_card.dart';
import 'package:places/ui/components/icon_box.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: mocks.length,
        itemBuilder: (context, index) {
          return SightCard(
            mocks[index],
            actions: [IconBox(icon: AppIcons.heart)],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      toolbarHeight: 72,
      title: SizedBox(
        width: double.infinity,
        child: RichText(
          textAlign: TextAlign.left,
          overflow: TextOverflow.fade,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 32,
                  height: 1.12,
                  fontWeight: FontWeight.w700,
                ),
            children: [
              TextSpan(text: 'Список\n'),
              TextSpan(text: 'Интересных мест'),
            ],
          ),
        ),
      ),
    );
  }
}
