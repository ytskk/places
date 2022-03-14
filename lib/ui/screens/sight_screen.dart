import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final titleTextTheme = Theme.of(context).textTheme.headline2;

    return Scaffold(
      appBar: CustomAppBar(
        height: 80,
        title: SizedBox(
          width: double.infinity,
          child: RichText(
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
            text: TextSpan(
              style: titleTextTheme,
              children: [
                TextSpan(text: AppStrings.sightTitleList),
                TextSpan(text: AppStrings.sightTitleInterestingPlaces),
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
          return SightCard(
            mocks[index],
            actions: [
              Button.icon(
                icon: AppIcons.heart,
                iconColor: Colors.white,
                background: Colors.transparent,
                onPressed: () {
                  print("Close icon clicked");
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
