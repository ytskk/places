import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/sight_card.dart';
import 'package:places/ui/screens/add_sight/add_sight_screen.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(AppStrings.sightTitle),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: _FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (builder) => AddSightScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          bottom: 72,
          right: 16,
        ),
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
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.black12,
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppStrings.sightFloatingButtonLabel.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(24),
    //     gradient: LinearGradient(
    //       colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
    //     ),
    //   ),
    //   child: ElevatedButton.icon(
    //     onPressed: onPressed,
    //     style: ButtonStyle(
    //       backgroundColor:
    //           MaterialStateProperty.resolveWith((states) => Colors.transparent),
    //       padding: MaterialStateProperty.resolveWith(
    //         (states) => EdgeInsets.symmetric(horizontal: 22, vertical: 12),
    //       ),
    //       shape: MaterialStateProperty.resolveWith(
    //         (states) => RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(24),
    //         ),
    //       ),
    //     ),
    //     label: Text(AppStrings.sightFloatingButtonLabel.toUpperCase()),
    //     icon: Icon(Icons.add),
    //   ),
    // );
  }
}
