import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/splash_screen_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: controller.iconScaleAnimation.value,
              child: Image.asset(
                'assets/icons/app_icon.png',
                height: 100.h,
                width: 100.w,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50.h,
          ),
          DefaultTextStyle(
            style: TextStyle(fontSize: 22.sp, color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold, fontFamily: Constants.kProtofoFonts),
            child: AnimatedTextKit(
              onFinished: () {
                controller.isAnimationCompleted.value = true;
                controller.onAnimationCompleted();
              },
              repeatForever: false,
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText('Toll Calculator', speed: const Duration(milliseconds: 100)),
                WavyAnimatedText('Toll Calculator'),
                FadeAnimatedText('Toll Calculator', duration: Duration(milliseconds: 1500)),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isAnimationCompleted.value,
              child: Text(
                'Toll Calculator',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
