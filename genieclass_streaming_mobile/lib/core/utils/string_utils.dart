import 'package:flutter/material.dart';

class StringUtils {
  static List<String> get alphabets {
    int currentASCII = 65;
    final List<String> results = <String>[];
    for (int i = 0; i < 26; i++) {
      results.add(
        String.fromCharCode(currentASCII++),
      );
    }
    return results;
  }

  static bool isNullOrEmptyString(String? value) {
    if (value == null || value.isEmpty == true) return true;
    return false;
  }

  static String normalizeStringValue(
    String? value, {
    String defaultValue = '-',
  }) {
    if (value == null || value.isEmpty == true) return defaultValue;

    return value;
  }

  static String removeZeroWidthSpaces(String value) =>
      value.replaceAll('', '\u200B');

  static String toTitleCase(String text) {
    final List<String> words = text.split(' ');
    final List<String> results = <String>[];
    for (final String word in words) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String restOfWord = word.substring(1).toLowerCase();
      results.add('$firstLetter$restOfWord');
    }
    return results.join(' ');
  }
}

extension StringX on String {
  String get overflowForSingleLine => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();
}
