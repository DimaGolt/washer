import 'package:flutter_test/flutter_test.dart';
import 'package:washer/shared/utils/string_regexp.dart';

void main() {
  group('Email tests', () {
    test('Acceptable email', () => expect(true, 'email@mail.com'.matchesEmail()));
    test('Email with wrong domain name', () => expect(false, 'email@.com'.matchesEmail()));
    test('Email with wrong top-level domain', () => expect(false, 'email@mail.c'.matchesEmail()));
    test('Email with no @ sign', () => expect(false, 'email.mail.com'.matchesEmail()));
    test('Email with no user', () => expect(false, '@mail.com'.matchesEmail()));
  });
  group('Password test', () {
    test('Acceptable password', () => expect(true, 'Test123'.matchesPassword()));
    test('Password with no uppercase letter', () => expect(false, 'test123'.matchesPassword()));
    test('Password with no lowercase letter', () => expect(false, 'TEST123'.matchesPassword()));
    test('Password with no number', () => expect(false, 'TestTest'.matchesPassword()));
    test('Password that shorter than 6 letters', () => expect(false, 'Tes2'.matchesPassword()));
  });
}
