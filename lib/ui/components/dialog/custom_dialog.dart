import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/models/dialog.dart';

/// A product design alert dialog.
///
/// An alert dialog informs the user about situations that require acknowledgement.
/// An alert dialog has an optional content and an optional list of actions.
/// The content is displayed above the actions and below the icon.
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.dialogState = DialogState.Success,
    this.content,
    this.actions,
  }) : super(key: key);

  /// Dialog state from [DialogState].
  final DialogState dialogState;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? content;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      contentTextStyle: theme.textTheme.bodyText2,
      title: _DialogStateIcon(
        dialogState: this.dialogState,
      ),
      content: content,
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(smallBorderRadius)),
      ),
      actions: actions,
    );
  }
}

class _DialogStateIcon extends StatelessWidget {
  const _DialogStateIcon({
    Key? key,
    required this.dialogState,
    this.child,
  }) : super(key: key);

  final DialogState dialogState;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final DialogData dialogData = DialogData.resolveData(dialogState);

    final dialogChild = child ?? Icon(dialogData.icon);

    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dialogData.color?.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Theme(
            data: ThemeData(iconTheme: IconThemeData(color: dialogData.color)),
            child: dialogChild,
          ),
        ),
      ),
    );
  }
}

Future<bool?> showAlertDialog(BuildContext context, Widget dialog) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
