import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:washu/app/app.dart';
import 'app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
    child: const WashuApp(),
    useOnlyLangCode: true,
    fallbackLocale: const Locale('en', 'US'),
    supportedLocales: const [Locale('en', 'US'), Locale('pl', 'PL')],
    path: 'assets/translations',
  ));
}
