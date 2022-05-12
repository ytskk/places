import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';

/// Defines the way the content is aligned.
enum IconAlignment {
  Horizontal,
  Vertical,
}

class ButtonPadding {
  static const Narrow = const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const Wide = const EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const UltraWide =
      const EdgeInsets.symmetric(vertical: 14, horizontal: 22);
}

/// A custom button that allows you to create both a regular text button and an icon button.
/// Icon alignment is controlled by [IconAlignment] enum.
class Button extends StatelessWidget {
  /// Create button with [text] (similar to label).
  const Button({
    Key? key,
    required String this.text,
    this.onPressed,
    Color? this.background,
    EdgeInsets? buttonPadding,
    this.textStyle,
    this.contentAlignment = MainAxisAlignment.center,
    this.borderRadius = smallBorderRadius,
    this.iconSize,
  })  : icon = null,
        iconColor = null,
        iconAlignment = null,
        gap = 0,
        padding = buttonPadding ?? ButtonPadding.Narrow,
        isTransparent = background == Colors.transparent,
        isDisabled = onPressed == null,
        super(key: key);

  /// Create button with both [text] (similar to label) and [icon] () or just with [icon] with [onPressed] callback
  /// (optional, if not provided, button is disabled).
  /// Create a button with both [icon] and [text] or just with [icon].
  ///
  /// [icon] and [text] arrangement are controlled by [iconAlignment] and padded by [padding] with a [gap] pixel gap in between.
  ///
  /// The [icon] must be not null.
  const Button.icon({
    Key? key,
    required String this.icon,
    Color? this.iconColor,
    String? this.text,
    this.onPressed,
    Color? this.background,
    IconAlignment? iconAlignment,
    EdgeInsets? buttonPadding,
    double? gap,
    this.textStyle,
    this.contentAlignment = MainAxisAlignment.center,
    this.borderRadius = smallBorderRadius,
    this.iconSize,
  })  : padding = buttonPadding ?? ButtonPadding.Narrow,
        gap = gap ?? 8,
        isTransparent = background == Colors.transparent,
        iconAlignment = iconAlignment ?? IconAlignment.Horizontal,
        isDisabled = onPressed == null,
        super(key: key);

  /// similar to label
  final String? text;

  /// actually represents iconName from [AppIcons]
  final String? icon;

  final Color? iconColor;

  final double? iconSize;

  /// decides in which direction icon and text are placed. By default [IconAlignment.Horizontal].
  final IconAlignment? iconAlignment;

  /// Padding around content. Recommended to use [ButtonPadding]. By default [ButtonPadding.Narrow])
  final EdgeInsets? padding;

  final TextStyle? textStyle;

  /// controls distance in logical pixels  between [icon] and [text] (if text is not null).
  /// By default 8 logical pixels.
  final double gap;

  /// Button background color (if null, defaults to default button background. Might be transparent)
  final Color? background;
  final bool isTransparent;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final MainAxisAlignment contentAlignment;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late final Color onPrimary;
    late final Color? primary;

    if (isTransparent) {
      primary = Colors.transparent;
    }

    // It is decided which background (primary) and content color (onPrimary) to use,
    // depending on the activity (is [onPressed] provided) and transparency (is [background] not [Colors.transparent]).
    if (isDisabled) {
      if (isTransparent) {
        onPrimary = theme.textTheme.bodyText2!.color!.withOpacity(0.4);
      } else {
        primary = background?.withOpacity(0.4);
        onPrimary = theme.textTheme.bodyText2!.color!.withOpacity(0.4);
      }
    } else {
      if (isTransparent) {
        onPrimary = theme.textTheme.bodyText2!.color!;
      } else {
        primary = background ?? theme.buttonTheme.colorScheme!.surface;
        onPrimary = Colors.white;
      }
    }

    final buttonTextStyle = theme.textTheme.bodyText2!
        .copyWith(
          fontSize: 14,
          color: onPrimary,
        )
        .merge(textStyle);

    final buttonText = text != null
        ? Text(
            text!,
            style: buttonTextStyle,
          )
        : null;
    final buttonIcon = icon != null
        ? IconBox(
            icon: icon!,
            color: iconColor ?? onPrimary,
            size: iconSize ?? smallIconSize,
          )
        : null;

    /// if icon is provided, returns [Column] or [Row] (depends on [IconAlignment]) with content
    final buttonContent = icon != null
        ? _ButtonWithIconContent(
            alignment: iconAlignment!,
            icon: buttonIcon!,
            text: buttonText,
            gap: gap,
            contentAlignment: contentAlignment,
          )
        : buttonText!;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle().copyWith(
        shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                )),
        backgroundColor: MaterialStateProperty.resolveWith((states) => primary),
        foregroundColor:
            MaterialStateProperty.resolveWith((states) => onPrimary),
        padding: MaterialStateProperty.resolveWith((states) => padding),
      ),
      child: buttonContent,
    );
  }
}

class _ButtonWithIconContent extends StatelessWidget {
  const _ButtonWithIconContent({
    Key? key,
    required this.alignment,
    required this.icon,
    required this.text,
    required this.gap,
    required this.contentAlignment,
  }) : super(key: key);

  final IconAlignment alignment;
  final IconBox icon;
  final Text? text;
  final double gap;
  final MainAxisAlignment contentAlignment;

  @override
  Widget build(BuildContext context) {
    return alignment == IconAlignment.Horizontal
        ? Row(
            mainAxisAlignment: contentAlignment,
            children: [
              icon,
              if (text != null)
                Padding(
                  padding: EdgeInsets.only(left: gap),
                  child: text,
                ),
            ],
          )
        : Column(
            mainAxisAlignment: contentAlignment,
            children: [
              icon,
              if (text != null)
                Padding(
                  padding: EdgeInsets.only(top: gap),
                  child: text,
                ),
            ],
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
  /// ```
  /// content: Row(
  ///   mainAxisSize: MainAxisSize.min,
  ///   children: […],
  /// ),
  /// ```
  const ButtonWithGradient({
    Key? key,
    this.onPressed,
    required this.content,
    this.padding = ButtonPadding.UltraWide,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget content;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(largeBorderRadius)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.black12,
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: brandGradient,
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
