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
class DialogData {
  final Color? color;
  final IconData? icon;

  /// **Arguments**
  /// - `color` — background color for [DialogWidget]
  /// - `icon` — returned IconData
  ///
  /// **Methods**
  /// - `resolveData` — static method to get [DialogData] for provided [dialogState]
  const DialogData({
    required Color? this.color,
    required IconData? this.icon,
  });

  /// get [DialogData] for provided [dialogState]
  static DialogData resolveData(DialogState dialogState) {
    switch (dialogState) {
      case DialogState.Success:
        return DialogData(color: Colors.green, icon: Icons.check);
      case DialogState.Error:
        return DialogData(color: Colors.red, icon: Icons.close);
      case DialogState.Alert:
        return DialogData(
          color: Colors.amber,
          icon: CupertinoIcons.question,
        );
    }
  }
}
