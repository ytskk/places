import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/sight_card.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:places/ui/screens/add_sight/add_sight_screen.dart';
import 'package:places/ui/screens/filter/filter_screen.dart';
import 'package:places/ui/screens/sight_search/sight_search_screen.dart';

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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: SearchBar(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => SightSearchScreen(),
                ),
              );
            },
            suffix: IconButton(
              padding: EdgeInsets.zero,
              icon: IconBox(
                icon: AppIcons.filter,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => FilterScreen()),
                );
              },
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: const _AddPlaceFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            // in order for fab not to close the content.
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
                    print("Wishlist icon clicked");
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// floating button for adding a new place.
class _AddPlaceFloatingButton extends StatelessWidget {
  const _AddPlaceFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWithGradient(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Container(
            child: SizedBox(
              width: 8,
            ),
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
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (builder) => const AddSightScreen(),
          ),
        );
      },
    );
  }
}

/// A custom button with brand gradient.
class ButtonWithGradient extends StatelessWidget {
  /// Creates a button with [content] and [onPressed] callback and custom [padding]
  /// (prefer to use [ButtonPadding]).
  ///
  /// If [content] is a multi child widget ([Row], [Column] and etc.),
  /// make sure that the minimum size is used.
  ///
  /// ```dart
  /// content: Row(
  ///   mainAxisSize: MainAxisSize.min,
  ///   children: […],
  /// ),
  /// ```
  const ButtonWithGradient({
    Key? key,
    VoidCallback? this.onPressed,
    required this.content,
    this.padding = ButtonPadding.UltraWide,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget content;
  final EdgeInsets padding;

  final _brandGradient = const LinearGradient(
    colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
  );

  LinearGradient get brandGradient => _brandGradient;

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
            gradient: _brandGradient,
          ),
          child: Padding(
            padding: padding,
            child: content,
          ),
        ),
      ),
    );
  }
}
