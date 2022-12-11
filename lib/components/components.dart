import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}
