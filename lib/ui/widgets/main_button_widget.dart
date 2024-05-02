import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class MainButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const MainButtonWidget({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: child,
      ),
    );
  }
}
