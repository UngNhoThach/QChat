import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/constants/imagesString.dart';

import 'widgets/onboading_widget.dart';
import '../../models/onboading_model.dart';

class onBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final List<onBoadingPageWidget> pages = [
    onBoadingPageWidget(
      model: onboadingModel(
        imgString: onBoadingImage1,
        title: 'Welcome to QChat',
        subTitle: '',
        color: colors.onBPage1Color,
        button: null,
      ),
    ),
    onBoadingPageWidget(
      model: onboadingModel(
        imgString: onBoadingImage2,
        title: 'If you are confused about what to do, just open QChat',
        subTitle: '',
        color: colors.onBPage3Color,
        button: null,
      ),
    ),
    onBoadingPageWidget(
      model: onboadingModel(
        imgString: onBoadingImage1,
        title: 'Open and try it now',
        subTitle: '',
        color: colors.onBPage1Color,
        button: null,
      ),
    ),
  ];

  // skip pages
  skip() {
    controller.jumpToPage(page: pages.length - 1);
  }

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }

  onPageChangedCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;
}
