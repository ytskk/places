import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';

enum IconAlignment {
  Horizontal,
  Vertical,
}

class ButtonPadding {
  static const Narrow = const EdgeInsets.symmetric(vertical: 6, horizontal: 8);
  static const Wide = const EdgeInsets.symmetric(vertical: 12, horizontal: 16);
}

/// A custom button that allows you to create both a regular text button and an icon.
/// Icon alignment is controlled by [IconAlignment] enum.
class Button extends StatelessWidget {
  final String? text;
  final String? icon;
  final IconAlignment? iconAlignment;
  final EdgeInsets? padding;
  final double gap;
  final Color? background;
  final bool isTransparent;
  final bool isDisabled;
  final Function()? onPressed;

  /// **Arguments**
  /// - `background` — if null, defaults to default button background.
  /// Might be transparent.
  /// - `buttonPadding` — padding around [text]. Recommended to use [ButtonPadding].
  /// By default [ButtonPadding.Narrow]
  const Button({
    Key? key,
    String? this.text,
    Function()? this.onPressed,
    Color? this.background,
    EdgeInsets? buttonPadding,
  })  : icon = null,
        iconAlignment = null,
        gap = 0,
        padding = buttonPadding ?? ButtonPadding.Narrow,
        isTransparent = background == Colors.transparent,
        isDisabled = onPressed == null,
        super(key: key);

  /// **Arguments**
  /// - `icon` — icon name from [AppIcons]. The button can only be with an icon.
  /// - `iconAlignment` — decides in which direction icon and text are placed.
  /// By default [IconAlignment.Horizontal].
  /// - `gap` — gap in logical pixels  between icon and text (if text is not null).
  /// By default 8 logical pixels.
  /// - `buttonPadding` — padding around button content ([text] and [icon]).
  /// Recommended to use [ButtonPadding]. By default [ButtonPadding.Narrow]
  const Button.icon({
    Key? key,
    required String this.icon,
    String? this.text,
    Function()? this.onPressed,
    Color? this.background,
    IconAlignment? iconAlignment,
    EdgeInsets? buttonPadding,
    double? gap,
  })  : padding = buttonPadding ?? ButtonPadding.Narrow,
        gap = gap ?? 8,
        isTransparent = background == Colors.transparent,
        iconAlignment = iconAlignment ?? IconAlignment.Horizontal,
        isDisabled = onPressed == null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late final Color onPrimary;
    late final Color primary;

    if (isTransparent) {
      primary = Colors.transparent;
    } else {
      onPrimary = Colors.white;
    }

    // It is decided which background (primary) and content color (onPrimary) to use,
    // depending on the activity (is [onPressed] provided) and transparency (is [background] not [Colors.transparent]).
    if (isDisabled) {
      if (isTransparent) {
        onPrimary = theme.textTheme.bodyText2!.color!.withOpacity(0.4);
      } else {
        primary = background?.withOpacity(0.4) ??
            theme.buttonTheme.colorScheme!.surface.withOpacity(0.4);
      }
    } else {
      if (isTransparent) {
        onPrimary = theme.textTheme.bodyText2!.color!;
      } else {
        primary = background ?? theme.buttonTheme.colorScheme!.surface;
      }
    }

    final buttonText = text != null ? Text(text!) : null;
    final buttonIcon = icon != null
        ? IconBox(
            icon: icon!,
            color: onPrimary,
          )
        : null;

    // if icon is provided, returns [Column] or [Row] (depends on [IconAlignment]) with content
    final buttonContent = icon != null
        ? _ButtonWithIconContent(
            alignment: iconAlignment!,
            icon: buttonIcon!,
            text: buttonText,
            gap: gap,
          )
        : buttonText!;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle().copyWith(
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
  final IconAlignment alignment;
  final IconBox icon;
  final Text? text;
  final double gap;

  const _ButtonWithIconContent({
    Key? key,
    required IconAlignment this.alignment,
    required IconBox this.icon,
    required Text? this.text,
    required double this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return alignment == IconAlignment.Horizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
