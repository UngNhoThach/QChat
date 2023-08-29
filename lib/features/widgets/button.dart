import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../../../main.dart';

class MyButton extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  final String text;
  final Color color;

  final TextStyle style;
  final double? border;
  const MyButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.text,
      required this.border,
      required this.style,
      required this.color});
  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;
    return SizedBox(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 25.sp,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                  text,
                  style: style,
                ),
              ],
            ),
          )),
    ));
  }
}

class MyButtonNotIcon extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final double? height;
  final double? border;
  final double? width;
  final TextStyle style;
  const MyButtonNotIcon(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap,
      required this.text,
      required this.style,
      required this.border,
      required this.color});
  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;
    return SizedBox(
        height: height,
        width: width,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(border!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: style,
                  ),
                ],
              )),
        ));
  }
}

class MyButtonAgree extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final TextStyle style;

  const MyButtonAgree(
      {super.key,
      required this.onTap,
      required this.text,
      required this.style});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(12, 61, 240, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}

// button text and icon
class buttonTextandIcon extends StatelessWidget {
  final Color? colorSn;
  final IconData icon;
  final Color colorBr;
  final Function()? onPress;
  final String? text;
  final double? height;
  final double? sizeIcon;
  final double? width;
  final TextStyle style;

  const buttonTextandIcon({
    super.key,
    required this.colorBr,
    required this.colorSn,
    required this.width,
    required this.height,
    required this.onPress,
    required this.text,
    required this.style,
    required this.sizeIcon,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: colorBr, // button color
        child: TextButton(
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                icon,
                size: sizeIcon,
                color: Colors.white,
              ),
              Text(
                text!,
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
