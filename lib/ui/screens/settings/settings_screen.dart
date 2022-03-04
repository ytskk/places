import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SettingsTable(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        AppStrings.settingsScreenAppTitle,
        style: theme.textTheme.bodyText2!.copyWith(
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
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
