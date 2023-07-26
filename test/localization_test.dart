import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final contentEn = await File('assets/translations/en.json').readAsString();
  final contentPl = await File('assets/translations/pl.json').readAsString();
  final english = jsonDecode(contentEn) as Map<String, dynamic>;
  final polish = jsonDecode(contentPl) as Map<String, dynamic>;

  group('Test PL translations', () {
    setUp(() {
      Localization.load(
        const Locale('pl'),
        translations: Translations(polish),
      );
    });

    test('Test Polish translation', () {
      for (String workName in english.keys) {
        expect(tr(workName), polish[workName]);
      }
    });
  });

  group('Test EN translations', () {
    setUp(() {
      Localization.load(
        const Locale('en'),
        translations: Translations(english),
      );
    });

    test('Test English translation', () {
      for (String workName in english.keys) {
        expect(tr(workName), english[workName]);
      }
    });
  });
}
