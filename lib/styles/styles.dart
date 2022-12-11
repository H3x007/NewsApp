import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle get subHeadingStyle {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
}

TextStyle get contentStyle {
  return TextStyle(
    fontSize: 14,
    color: Colors.grey[800],
    fontWeight: FontWeight.w500,
  );
}

TextStyle get subTitleStyle {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20.0,
  );
}

TextStyle get titleStyle {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16.0,
    height: 1.3,
  );
}
