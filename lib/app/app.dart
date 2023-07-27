import 'package:flutter/material.dart';
import 'package:washu/app/router.dart';
import 'package:washu/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class WashuApp extends StatelessWidget {
  WashuApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Washu',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: washuLightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}