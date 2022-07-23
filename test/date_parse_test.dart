import 'package:digital_14_task/core/helpers/date_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:digital_14_task/main.dart';

void main() {
  group('Date Formatter', () {
    test('test Date Parser Class with a valid date', () async {
      String date = CustomDateParser.convertDateFormat('2022-07-23T19:05:00');

      expect(date, 'Sat, 23 Jul 2022 -- 07:05PM');
    });

    test('test Date Parser Class with a wrong date format from backend side',
        () async {
      String date = CustomDateParser.convertDateFormat('2022-07-2319:05:00');

      expect(date, '2022-07-2319:05:00');
    });
  });
}
