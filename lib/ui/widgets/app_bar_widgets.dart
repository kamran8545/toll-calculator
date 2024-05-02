import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.kTextColor,
        fontFamily: Constants.kProtofoFonts,
      ),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          WavyAnimatedText(
            'Toll Calculator',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
