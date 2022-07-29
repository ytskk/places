import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/navigation/app_route_names.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      primary: false,
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
        ListTile(
          title: Text('Сбросить туториал'),
          subtitle: Text('Временно'),
          onTap: () {
            context.read<PreferencesCubit>().setFirstOpen(true);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Туториал сброшен'),
                  action: SnackBarAction(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    label: 'Закрыть',
                  ),
                ),
              );
          },
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
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (BuildContext context, state) {
        final isDarkMode = state.isDarkMode;

        return Switch.adaptive(
          value: isDarkMode,
          onChanged: (_) => context.read<PreferencesCubit>().toggleDarkMode(),
        );
      },
    );
  }
}
