import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/onboading_model.dart';

class onBoadingPageWidget extends StatelessWidget {
  const onBoadingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final onboadingModel model;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15.sp),
      color: model.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage(model.imgString),
            height: mq.height * 0.5,
          ),
          Text(
            model.title,
          ),
          Text(
            model.subTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
