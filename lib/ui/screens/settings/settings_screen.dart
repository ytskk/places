import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          AppStrings.settingsScreenAppTitle,
        ),
      ),
      body: SettingsTable(),
    );
  }
}

class SettingsTable extends StatefulWidget {
  const SettingsTable({Key? key}) : super(key: key);

  @override
  SettingsTableState createState() => SettingsTableState();
}

class SettingsTableState extends State<SettingsTable> {
  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    bool isDarkTheme = context.read<Settings>().isDarkTheme;

    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            title: Text(AppStrings.settingsScreenDarkThemeTitle),
            trailing: Switch.adaptive(
              value: isDarkTheme,
              onChanged: (bool newValue) {
                setState(() {
                  context.read<Settings>().setIsDarkTheme(!isDarkTheme);
                });
                log("Theme changed to ${isDarkTheme ? "dark" : "light"}");
              },
            ),
          ),
          ListTile(
            title: Text(AppStrings.settingsScreenTutorialTitle),
            trailing: IconButton(
              color: iconColor,
              onPressed: () {
                log("Info button pressed");
              },
              icon: Icon(Icons.info_outline),
            ),
          ),
        ],
      ).toList(),
    );
  }
}
