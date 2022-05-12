import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/domain/app_constants.dart';
import 'package:provider/provider.dart';

String _defaultCancelText = 'Cancel';
String _defaultConfirmText = 'Select';

TextStyle _cupertinoActionTextStyle = TextStyle(
  fontFamily: '.SF UI Text',
  inherit: false,
  fontSize: 17.0,
  fontWeight: FontWeight.w400,
  textBaseline: TextBaseline.alphabetic,
);

/// Creates date oriented picker.
///
/// Can be separate: from android or ios and both as adaptive.
class Picker {
  Picker.Android({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    this.cancelText,
    this.confirmText,
    lastDate,
  })  : this.lastDate = lastDate ?? initialDate.add(Duration(days: 31)),
        _picker = AndroidPicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          confirmText: confirmText,
          cancelText: cancelText,
        );

  Picker.Cupertino({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    lastDate,
    this.cancelText,
    this.confirmText,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
  })  : this.lastDate = lastDate ?? initialDate.add(Duration(days: 31)),
        _picker = CupertinoPicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          confirmText: confirmText,
          cancelText: cancelText,
          mode: mode,
        );

  Picker.Adaptive({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    lastDate,
    this.cancelText,
    this.confirmText,
  })  : this.lastDate = lastDate ?? initialDate.add(Duration(days: 31)),
        _picker = AdaptivePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          confirmText: confirmText,
          cancelText: cancelText,
        );

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? cancelText;
  final String? confirmText;
  final CustomPicker _picker;

  Future<DateTime?> show(BuildContext context) {
    return _picker.show(context);
  }
}

abstract class CustomPicker {
  Widget create(BuildContext context);

  Future<DateTime?> show(BuildContext context);

  static Future<DateTime?> _getDialog(BuildContext context, Widget child) {
    // TODO: implement _getDialog
    throw UnimplementedError();
  }
}

class AndroidPicker extends CustomPicker {
  AndroidPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.cancelText,
    this.confirmText,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? cancelText;
  final String? confirmText;

  // TODO: implement time picker.
  @override
  Widget create(BuildContext context) {
    return Theme(
      data: _dateTimePickerThemeData(context),
      // child: TimePickerDialog(
      //   initialTime: TimeOfDay.now(),
      // ),
      child: DatePickerDialog(
        cancelText: cancelText,
        confirmText: confirmText,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      ),
    );
  }

  @override
  Future<DateTime?> show(BuildContext context) {
    return _getDialog(context, create(context));
  }

  @override
  static Future<DateTime?> _getDialog(BuildContext context, Widget child) {
    return showDialog(context: context, builder: (context) => child);
  }
}

class CupertinoPicker extends CustomPicker {
  CupertinoPicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.cancelText,
    this.confirmText,
    this.mode = CupertinoDatePickerMode.dateAndTime,
  }) : selectedDate = initialDate;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? cancelText;
  final String? confirmText;
  final CupertinoDatePickerMode mode;

  DateTime? selectedDate;

  @override
  // ignore: long-method
  Widget create(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.read<Settings>().isDarkTheme
        ? Brightness.dark
        : Brightness.light;

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return OrientationBuilder(
          builder: ((context, orientation) => DecoratedBox(
                decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (cancelText != null)
                            CupertinoButton(
                                child: Text(
                                  cancelText!,
                                  style: _cupertinoActionTextStyle.copyWith(
                                    color: theme.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          Spacer(),
                          CupertinoButton(
                            child: Text(
                              confirmText ?? _defaultConfirmText,
                              style: _cupertinoActionTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(selectedDate);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 240.0,
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          brightness: brightness,
                        ),
                        child: CupertinoDatePicker(
                          mode: mode,
                          minimumDate: firstDate,
                          maximumDate: lastDate,
                          onDateTimeChanged: (value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  @override
  Future<DateTime?> show(BuildContext context) {
    return _getDialog(context, create(context));
  }

  @override
  static Future<DateTime?> _getDialog(BuildContext context, Widget child) {
    return showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      builder: (context) => child,
    );
  }
}

class AdaptivePicker extends CustomPicker {
  AdaptivePicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.cancelText,
    this.confirmText,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? cancelText;
  final String? confirmText;

  @override
  Widget create(BuildContext context) {
    /// depends on platform
    return Platform.isIOS
        ? CupertinoPicker(
            initialDate: initialDate,
            firstDate: firstDate,
            confirmText: confirmText,
            lastDate: lastDate,
            cancelText: cancelText,
          ).create(context)
        : AndroidPicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            confirmText: confirmText,
            cancelText: cancelText,
          ).create(context);
  }

  @override
  Future<DateTime?> show(BuildContext context) {
    return _getDialog(context, create(context));
  }

  @override
  Future<DateTime?> _getDialog(BuildContext context, Widget child) {
    return Platform.isIOS
        ? CupertinoPicker._getDialog(context, child)
        : AndroidPicker._getDialog(context, child);
  }
}

ThemeData Function(BuildContext context) _dateTimePickerThemeData =
    (BuildContext context) {
  final theme = Theme.of(context);

  return ThemeData(
    dialogBackgroundColor: theme.scaffoldBackgroundColor,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(smallBorderRadius),
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: theme.primaryColor,
      onSurface: theme.textTheme.bodyText2!.color!,
    ),
  );
};
