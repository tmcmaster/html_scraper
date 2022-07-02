import 'package:html_scraper/src/parsers/url_parser.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Test URLParser', () {
    test('No Arguments', () {
      expect(URLParser().parse(), isNull);
    });
    test('Just URL', () {
      final url = 'https://dite.com';
      final value = URLParser(
        url: url,
      ).parse();
      expect(value, url);
    });
    test('Test separator', () {
      final code = 'code';
      final value = URLParser(
        url: 'https://dite.com/a/b/$code',
        separator: '/b/',
      ).parse();
      expect(value, code);
    });
    test('Test multipart separator', () {
      final code = 'code';
      final value = URLParser(
        url: 'https://dite.com/a/b/c/d/$code',
        separator: '/b/c/d/',
      ).parse();
      expect(value, code);
    });
    test('Strip URL trailing slash', () {
      final code = 'code';
      final value = URLParser(
        url: 'https://dite.com/a/b/$code/',
        separator: '/b/',
      ).parse();
      expect(value, code);
    });
    test('Test segment', () {
      final code = 'code';
      final value = URLParser(
        url: 'https://dite.com/a/b/$code/c/d',
        separator: '/',
        segment: 5,
      ).parse();
      expect(value, code);
    });
  });
}
