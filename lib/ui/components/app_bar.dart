import 'package:flutter/material.dart';

/// Custom implemented [AppBar].
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? background;

  /// **Arguments**
  /// - `title` as [Widget]. Uses [titleTextStyle] if text style is not provided.
  /// - `bottom` — [PreferredSizeWidget]
  /// - `height` — height of AppBar, except [bottom], similar to [AppBar.toolbarHeight],
  /// defaults to [kToolbarHeight]
  const CustomAppBar({
    Key? key,
    Widget? this.title,
    // The height of the title component of the [AppBar]
    double this.height = kToolbarHeight,
    PreferredSizeWidget? this.bottom,
    List<Widget>? this.actions,
    Widget? this.leading,
    Color? this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextStyle titleTextStyle = theme.textTheme.bodyText2!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );
    final Color backgroundColor = background ?? theme.scaffoldBackgroundColor;

    return AppBar(
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
