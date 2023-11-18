import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:washer/app/router.dart';
import 'package:washer/app/theme.dart';
import 'package:washer/feature/settings/presentation/widgets/settings_button.dart';
import 'package:washer/shared/utils/language_local.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../widgets/settings_dropdown.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWave(
        title: 'settings',
      ),
      body: WasherScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _accountSetting(context),
            _applicationSetting(context),
          ],
        ),
      ),
    );
  }

  _accountSetting(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Account:',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
              ),
            ),
          ),
          SettingsButton(
            icon: Icons.account_circle,
            text: 'Edit personal information',
            onPressed: () {},
          ),
          SettingsButton(
            icon: Icons.wallet,
            text: 'Edit wallet information',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _applicationSetting(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Application:',
              style: TextStyle(
                color: color,
                fontSize: 32,
              ),
            ),
          ),
          SettingsButton(
            icon: Icons.notifications,
            text: 'Notifications',
            onPressed: () {},
          ),
          SettingsDropdown<Locale>(
            icon: Icons.language,
            text: 'Language',
            onChanged: (val) {},
            items: context.supportedLocales,
            selectedItem: context.locale,
            itemBuilder: (locale) {
              return DropdownMenuItem(
                value: locale,
                child: Text(
                  LanguageLocal.getDisplayLanguage(locale.languageCode)['name'],
                  style: TextStyle(color: color),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
