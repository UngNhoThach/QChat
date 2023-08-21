import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/constants/size.dart';
import 'package:qchat/constants/colors.dart';

import '../../../../main.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String title;
  final TextStyle style;

  const SquareTile(
      {super.key,
      required this.onTap,
      required this.imagePath,
      required this.title,
      required this.style});
  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: md.height * 0.04,
            ),
            SizedBox(width: md.width * 0.04),
            Text(
              title,
              style: style,
            )
          ],
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

class Circle_img_profile extends StatelessWidget {
  final Function()? onPress;
  final double height;
  final double width;
  final String img;
  final IconData? icon;
  final Color? color;
  Circle_img_profile({
    super.key,
    required this.onPress,
    required this.height,
    required this.width,
    required this.img,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(img)),
          Positioned(
              bottom: 0,
              right: -25,
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Color(0xFFF5F6F9),
                child: IconButton(
                  onPressed: onPress,
                  icon: Icon(icon),
                  color: color,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )),
        ],
      ),
    );
  }
}

class Circle_img_user extends StatelessWidget {
  final double height;
  final double width;
  final String img;
  final Color? colorBr;
  Circle_img_user({
    super.key,
    required this.height,
    required this.width,
    required this.img,
    required this.colorBr,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(img)),
          Positioned(
            bottom: 0,
            right: 10,
            child: CircleAvatar(
              backgroundColor: colorBr,
              radius: 8,
            ),

            // constraints: BoxConstraints(
            //   minWidth: 0.2, // Minimum width of the button
            //   minHeight: 0.2,
            // ),
            // onPressed: () {},
            // // elevation: 2.0,
            // fillColor: colorBr,
            // padding: EdgeInsets.all(8.0),
            // shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}

class Square_item extends StatelessWidget {
  static TextStyle _textStyle = TextStyle(
    fontSize: fontSizes.xxxsmall,
    color: Colors.black,
  );
  final IconData icon;
  final String title;
  final String detail;
  const Square_item(
      {super.key,
      required this.icon,
      required this.detail,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.main_color, width: 2),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Container(
        padding: EdgeInsets.all(10.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              CircleAvatar(
                radius: iconSizes.xxxsmall,
                backgroundColor: Color.fromRGBO(12, 61, 240, 0.3),
                child: Icon(
                  icon,
                  size: iconSizes.xxxsmall,
                  color: colors.main_color,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class SquareTile_small extends StatelessWidget {
  final String imagePath;
  const SquareTile_small({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            child: Image.asset(
              imagePath,
              height: 20.0.h,
              alignment: Alignment.bottomCenter,
              width: 30.0.w,
            ),
          ),
        ],
      ),
    );
  }
}
