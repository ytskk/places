import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';

/// Custom implemented [AppBar].
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Created design specified AppBar.
  const CustomAppBar({
    Key? key,
    this.title,
    // The height of the title component of the [AppBar]
    this.height = kToolbarHeight,
    this.bottom,
    this.actions,
    this.leading,
    this.background,
    this.automaticallyImplyLeading = false,
  }) : super(key: key);

  /// Height of AppBar, except [bottom], similar to [AppBar.toolbarHeight],
  /// defaults to [kToolbarHeight].
  final double height;

  /// Uses [titleTextStyle] if text style is not provided.
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? background;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextStyle titleTextStyle = theme.textTheme.bodyText2!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );
    final Color backgroundColor = background ?? theme.scaffoldBackgroundColor;

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: largeLeadingWidth,
      titleTextStyle: titleTextStyle,
      title: title,
      actions: actions,
      leading: leading,
      toolbarHeight: height,
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}
