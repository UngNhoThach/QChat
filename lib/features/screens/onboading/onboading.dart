import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/constants/textString.dart';
import 'package:qchat/features/screens/home_Screen.dart';
import 'package:qchat/features/widgets/nextscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../main.dart';
import '../../widgets/button.dart';
import 'onboadingCotroller.dart';

class onBoading extends StatefulWidget {
  const onBoading({Key? key}) : super(key: key);
  @override
  State<onBoading> createState() => _onBoadingState();
}

class _onBoadingState extends State<onBoading> {
  bool onLastPage = false;
  final obController = onBoardingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // index = obController.pages.length;

    // get size of screen
    md = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obController.pages,
            enableSideReveal: true,
            liquidController: obController.controller,

            // check and show lastPage
            onPageChangeCallback: (index) {
              setState(() {
                onLastPage = (index == 2);
                // animation next page
                obController.onPageChangedCallback(index);
              });
            },
            waveType: WaveType.circularReveal,
          ),
          Positioned(
            top: 50.h,
            right: 20.w,
            child: TextButton(
              onPressed: () => obController.skip(),
              child: const Text("Skip", style: TextStyle(color: Colors.black)),
            ),
          ),
          Positioned(
              bottom: 60.h,
              child: Row(
                children: [
                  onLastPage
                      ? MyButtonNotIcon(
                          onTap: () => nextScreenRe(context, homeScreen()),
                          style: textString.text_Button,
                          text: 'Sign up',
                          color: colors.main_color,
                          border: 15,
                          height: null,
                          width: 100.w,
                        )
                      : MyButtonNotIcon(
                          color: colors.main_color,
                          onTap: () => obController.animateToNextSlide(),
                          style: textString.text_Button,
                          border: 15,
                          text: 'Next',
                          height: null,
                          width: 100.w)
                ],
              )),
          Obx(
            () => Positioned(
              bottom: 155.h,
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: obController.currentPage.value,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xff272727),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
