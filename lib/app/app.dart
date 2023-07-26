import 'package:flutter/material.dart';
import 'package:washu/app/theme.dart';
import 'package:washu/feature/landing/presentation/screens/landing_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class WashuApp extends StatelessWidget {
  const WashuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washu',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: washuLightTheme,
      home: const LandingScreen(),
    );
  }
}