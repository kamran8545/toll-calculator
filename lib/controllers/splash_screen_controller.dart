import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/utils/route_management.dart';
import 'package:toll_calculator/utils/session_management.dart';

class SplashScreenController extends GetxController {
  final GlobalKey<ScaffoldState> screenKey = GlobalKey<ScaffoldState>();

  RxBool isAnimationCompleted = false.obs;
  RxDouble iconScaleAnimation = 1.0.obs;

  late Timer scaleAnimationTimer;

  @override
  void onInit() {
    scaleAnimationTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      iconScaleAnimation.value += 0.2;
      if (iconScaleAnimation.value >= 2.0) {
        iconScaleAnimation.value = 1;
      }
    });
    super.onInit();
  }

  void onAnimationCompleted() async {
    scaleAnimationTimer.cancel();

    SessionManagement sessionManagement = Get.find<SessionManagement>();
    if (await sessionManagement.isUserLogin()) {
      Get.toNamed(RouteNames.kHomeScreenRoute);
    } else {
      Get.toNamed(RouteNames.kLoginScreenRoute);
    }
  }

}
