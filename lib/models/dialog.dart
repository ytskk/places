import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Describes dialog state.
enum DialogState {
  Success,
  Error,
  Alert,
}

/// A model for building [DialogWidget], describing, depending on the received
/// [DialogStates], a set of [icon] and [color].
///
/// Creates an object from the [DialogData.resolveData(dialogState)].
class DialogData {
  /// Collects dialog data (color and icon).
  const DialogData({
    required this.color,
    required this.icon,
  });

  /// background color for [DialogWidget]
  final Color? color;

  /// returned [IconData].
  ///
  /// ```
  /// Icons.close
  /// ```
  final IconData? icon;

  /// get [DialogData] for provided [dialogState]
  static DialogData resolveData(DialogState dialogState) {
    switch (dialogState) {
      case DialogState.Success:
        return DialogData(color: Colors.green, icon: Icons.check);
      case DialogState.Error:
        return DialogData(color: Colors.red, icon: Icons.close);
      case DialogState.Alert:
        return DialogData(color: Colors.amber, icon: CupertinoIcons.question);
    }
  }
}
