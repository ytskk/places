import 'package:flutter/material.dart';
import 'package:places/controllers/tutor_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:provider/provider.dart';

/// Height of list content is 1/2 of the screen height, when the page indicator
/// fills remaining space and places at the center. And action button is a floating action button.
class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          // Shows skip button if its not the last page.
          if (context.watch<Tutor>().currentPage !=
              context.read<Tutor>().tutorContent.length - 1)
            TextButton(
              onPressed: () {},
              child: Text(AppStrings.tutorAppBarSkipButtonText),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // To get a transparent background
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OnboardingPageIndicator(),
          const SizedBox(height: 24),
          if (context.watch<Tutor>().currentPage ==
              context.read<Tutor>().tutorContent.length - 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: _OnboardingActionButton(),
                ),
              ),
            ),
        ],
      ),
      body: _OnboardingPages(),
    );
  }
}

/// Page indicator is a row of dots, one for each page.
/// The current page is highlighted by primary color.
class _OnboardingPageIndicator extends StatelessWidget {
  const _OnboardingPageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int currentPage = context.watch<Tutor>().currentPage;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < context.read<Tutor>().tutorContent.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              margin: EdgeInsets.only(right: 4),
              curve: Curves.easeOut,
              height: 8,
              width: currentPage == i ? 24 : 8,
              decoration: BoxDecoration(
                color:
                    currentPage == i ? theme.primaryColor : theme.disabledColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
      ],
    );
  }
}

class _OnboardingActionButton extends StatelessWidget {
  const _OnboardingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      text: AppStrings.tutorStartButtonTitle.toUpperCase(),
      buttonPadding: ButtonPadding.UltraWide,
      // TODO: implement onPressed callback.
      onPressed: () {},
    );
  }
}

class _OnboardingPages extends StatefulWidget {
  const _OnboardingPages({Key? key}) : super(key: key);

  @override
  State<_OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<_OnboardingPages> {
  late final _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tutor = context.read<Tutor>();

    return PageView.builder(
      controller: _pageController,
      onPageChanged: (page) {
        context.read<Tutor>().setPage = page;
      },
      itemCount: tutor.tutorContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              Padding(
                // To center content vertically. And to avoid overlapping of text and indicator.
                padding: const EdgeInsets.only(bottom: 120),
                child: InfoList(
                  iconName: tutor.tutorContent[index].icon,
                  iconColor: theme.textTheme.bodyText2!.color,
                  iconSize: 128,
                  iconPaddingBottom: 40,
                  title: Text(
                    tutor.tutorContent[index].title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline3,
                  ),
                  subtitle: Text(
                    tutor.tutorContent[index].subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
