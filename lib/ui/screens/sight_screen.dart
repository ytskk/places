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
      floatingActionButton: _FloatingActionButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

class _FloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;

  const _FloatingActionButton({Key? key, void Function()? this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
          (states) => EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      label: Text(AppStrings.sightFloatingButtonLabel.toUpperCase()),
      icon: Icon(Icons.add),
    );
  }
}
