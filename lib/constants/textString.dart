import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'size.dart';

class textString {
  static TextStyle heading1 = TextStyle(
    fontSize: fontSizes.small,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: fontSizes.xsmall,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: fontSizes.xxsmall,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle text_ButtonSmall = TextStyle(
    fontSize: fontSizes.xxxsmall,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle text_Button = TextStyle(
    fontSize: fontSizes.xxsmall,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text_Button_BL = TextStyle(
    fontSize: fontSizes.xxsmall,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle text_Body = TextStyle(
    fontSize: fontSizes.xxxsmall,
    color: Colors.black,
  );

  static TextStyle text_link = TextStyle(
    fontSize: fontSizes.xxxsmall,
    color: colors.color_button,
    fontWeight: FontWeight.bold,
  );

  static TextStyle text_caption = TextStyle(
    fontSize: fontSizes.xxsmall,
    color: Colors.grey,
  );
}
