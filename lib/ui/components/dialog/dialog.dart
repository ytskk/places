import 'package:flutter/material.dart';
import 'package:places/models/dialog.dart';

class DialogWidget extends StatelessWidget {
  final DialogState dialogState;
  final Widget? content;
  final List<Widget>? actions;

  const DialogWidget({
    Key? key,
    DialogState this.dialogState = DialogState.Success,
    Widget? this.content,
    List<Widget>? this.actions,
  }) : super(key: key);

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
        borderRadius: BorderRadius.circular(12),
      ),
      actions: actions,
    );
  }
}

class _DialogStateIcon extends StatelessWidget {
  final DialogState dialogState;
  final Widget? child;

  const _DialogStateIcon({
    Key? key,
    required DialogState this.dialogState,
    Widget? this.child,
  }) : super(key: key);

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
