import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/navigation/app_route_names.dart';
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
      body: const SettingsTable(),
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
    final splashColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2);

    return ListView(
      children: [
        ListTile(
          title: Text(AppStrings.settingsScreenDarkThemeTitle),
          trailing: _SettingsDarkModeSwitcher(),
        ),
        const HorizontalDivider(),
        ListTile(
          title: Text(AppStrings.settingsScreenTutorialTitle),
          trailing: IconButton(
            splashColor: splashColor,
            padding: EdgeInsets.zero,
            splashRadius: 24,
            color: iconColor,
            onPressed: () {
              log('Info button pressed');
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteNames.onBoarding,
                (route) => false,
                arguments: AppRouteNames.settings,
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ),
        const HorizontalDivider(),
      ],
    );
  }
}

class _SettingsDarkModeSwitcher extends StatefulWidget {
  const _SettingsDarkModeSwitcher({Key? key}) : super(key: key);

  @override
  State<_SettingsDarkModeSwitcher> createState() =>
      _SettingsDarkModeSwitcherState();
}

class _SettingsDarkModeSwitcherState extends State<_SettingsDarkModeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsInteractor>(
      builder: (BuildContext context, value, Widget? child) {
        final isDarkMode = value.isDarkMode();

        return Switch.adaptive(
          value: isDarkMode,
          onChanged: (bool newValue) {
            // tmp !isDarkMode cos setter is async.
            log('Theme changed to ${!isDarkMode ? 'dark' : 'light'}');

            setState(() {
              context.read<SettingsInteractor>().setDarkMode(!isDarkMode);
            });
          },
        );
      },
    );
  }
}
