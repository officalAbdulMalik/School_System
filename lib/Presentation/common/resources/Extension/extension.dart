import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

extension CustomSizedBoxExt on num {
  SizedBox get x => SizedBox(width: w);
  SizedBox get y => SizedBox(height: h);
}

extension OfficeTimingsExtension on String {
  List<String> getOfficeTimings(String season) {
    // "Office Timing: Summer  (10:00am  08:00pm), Winter  (10:00am  07:00pm)"
    final seasonSplit = season.split("Office Timing:");

    final seasonSplit2 = seasonSplit[1].split(",");

    final summer = seasonSplit2[0].split("Summer")[1];

    final winter = seasonSplit2[1].split("Winter")[1];

    return [summer, winter];
  }
}

extension date on DateTime {
  ///Example:
  ///Convert 2023-5-9 21:12:23:000Z to 9,May 2023

  String get toPkDate {
    int day = this.day;
    var monthNames = [
      " ",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${day} ${monthNames[this.month]}, ${this.year}";
  }

  ///Example:
  ///Convert 2023-5-9 21:12:23:000Z to 9:12:23 PM
  String get toPkTime {
    int hour = this.hour;
    int minute = this.minute;
    int sec = this.second;

    return "${hour > 12 ? hour - 12 : hour}:$minute:$sec ${hour > 12 ? "PM" : "AM"}";
  }

  ///Example:
  ///Convert 2023-5-9 21:12:23:000Z to 9:12 PM
  String get toHourAndMinutes {
    int hour = this.hour;
    int minute = this.minute;
    int sec = this.second;

    return "${hour > 12 ? hour - 12 : hour}:$minute ${hour > 12 ? "PM" : "AM"}";
  }

  String timeAgo({bool numericDates = true}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  String get humanReadableDate {
    //print("object");
    return intl.DateFormat('yyyy-MM-dd').format(this);
  }

  String get weekName {
    return DateFormat('EEEE').format(this);
  }

  DateTime get nowTypeFormatData {
    DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    String formattedDate = outputFormat.format(this);

    return DateTime.parse(formattedDate);
  }
}

extension str on String {
  String get readableTime {
    DateTime dateTime = DateTime.parse(this);
    String timeString = DateFormat.Hm().format(dateTime);
    return timeString;
  }
}

extension StringExt2 on int {
  // String getMonthName(bool isJalali){
  //   if(isJalali)
  //     return this.jalaliMonthName;
  //   else
  //     return this.gregorianMonthName;
  // }
}
