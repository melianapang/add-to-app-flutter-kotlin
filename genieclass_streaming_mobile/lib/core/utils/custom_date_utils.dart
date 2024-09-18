import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  static final _systemDefaultSourceDateFormat = DateFormat('yyyy-MM-dd');
  static final _systemDefaultTargetDateFormat = DateFormat('dd MMMM yyyy');

  static String get thisYearStartDateSystemDate {
    final now = DateTime.now();
    final year = now.year;
    return '$year-01-01';
  }

  static String get thisYearEndDateSystemDate {
    final now = DateTime.now();
    final year = now.year;
    return '$year-12-31';
  }

  static String convertToHumanDate(
    String date, {
    DateFormat? sourceFormat,
    DateFormat? desiredFormat,
  }) {
    final dateTime =
        (sourceFormat ?? _systemDefaultSourceDateFormat).parse(date);
    final finalDesiredFormat = desiredFormat ?? _systemDefaultTargetDateFormat;
    return finalDesiredFormat.format(dateTime);
  }

  static DateTime fromSystemDateStringToDateTime(
    String date, {
    DateFormat? sourceFormat,
    DateFormat? desiredFormat,
  }) {
    final dateTime =
        (sourceFormat ?? _systemDefaultSourceDateFormat).parse(date);
    return dateTime;
  }

  static String fromDateTimeToHumanDate(
    DateTime dateTime, {
    DateFormat? sourceFormat,
    DateFormat? desiredFormat,
  }) {
    return _systemDefaultTargetDateFormat.format(dateTime);
  }

  static String fromDateTimeToSystemDate(DateTime dateTime) {
    return _systemDefaultSourceDateFormat.format(dateTime);
  }

  static String getRelativeTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    Duration difference = DateTime.now().difference(dateTime);
    int differenceInSeconds = difference.inSeconds;

    if (differenceInSeconds < 60) {
      return '1 menit yang lalu';
    } else if (differenceInSeconds < 3600) {
      int minutes = (differenceInSeconds / 60).floor();
      return '$minutes menit yang lalu';
    } else if (differenceInSeconds < 86400) {
      int hours = (differenceInSeconds / 3600).floor();
      return '$hours jam yang lalu';
    } else if (differenceInSeconds < 172800) {
      return 'Kemarin';
    } else {
      int days = difference.inDays;
      return '$days hari yang lalu';
    }
  }

  static bool isSameDate(
    DateTime prevDate,
    DateTime curretDate,
  ) {
    return prevDate.year == curretDate.year &&
        prevDate.month == curretDate.month &&
        prevDate.day == curretDate.day;
  }

  static DateTime removeTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String removeDate(TimeOfDay time) {
    String hour = '';
    if (time.hour < 10) {
      hour = '0${time.hour}';
    } else {
      hour = time.hour.toString();
    }
    String minute = '';
    if (time.minute < 10) {
      minute = '0${time.minute}';
    } else {
      minute = time.minute.toString();
    }
    return '$hour:$minute';
  }

  static String fromDateTimetoTime(
    DateTime dateTime, {
    bool includeSeconds = false,
  }) {
    final String hour =
        dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    final String minute = dateTime.minute < 10
        ? '0${dateTime.minute}'
        : dateTime.minute.toString();
    final String second = dateTime.second < 10
        ? '0${dateTime.second}'
        : dateTime.second.toString();
    String result = '$hour:$minute';
    if (includeSeconds) {
      result = '$result:$second';
    }
    return result;
  }

  static bool dateTimeIsToday(DateTime dateTime) {
    final DateTime now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  static bool stringIsToday(String dateTime) {
    final DateTime now = DateTime.now();
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    return parsedDateTime.year == now.year &&
        parsedDateTime.month == now.month &&
        parsedDateTime.day == now.day;
  }
}
