import 'package:flutter/material.dart';

class sizeBoxLine extends StatelessWidget {
  final double height;
  const sizeBoxLine({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }
}
