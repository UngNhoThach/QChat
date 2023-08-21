import 'package:flutter/material.dart';

class onboadingModel {
  final String imgString;
  final String title;
  final Color color;
  final StatelessWidget? button;

  // final Double size;
  final String subTitle;
  onboadingModel({
    required this.imgString,
    required this.title,
    required this.color,

    // required this.size,
    required this.subTitle,
    required this.button,
  });
}
