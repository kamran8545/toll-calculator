import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/controllers/login_screen_controller.dart';
import 'package:toll_calculator/ui/widgets/main_button_widget.dart';

import '../../utils/app_colors.dart';
import '../widgets/app_bar_widgets.dart';
import '../widgets/text_field_widget.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kWhiteColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const AppBarWidget(),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(25.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700, color: AppColors.kTextColor),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, height: 1),
                ),
                Text(
                  'Login to get started!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kGreyColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Email address',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(height: 5.h),
                TextFieldWidget(
                  focusNode: controller.emailFC,
                  textEditingController: controller.emailTEController,
                  hintText: 'example@gmail.com',
                ),
                SizedBox(height: 15.h),
                Text(
                  'Password',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(height: 5.h),
                TextFieldWidget(
                  focusNode: controller.passwordFC,
                  textEditingController: controller.passwordTEController,
                  hintText: '******',
                ),
                SizedBox(height: 15.h),
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () => MainButtonWidget(
                    onTap: controller.onLoginPressed,
                    child: controller.isLoading.value
                        ? SizedBox(
                            width: 20.w,
                            height: 17.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              color: AppColors.kWhiteColor,
                            ),
                          )
                        : Text(
                            'Login',
                            style: TextStyle(fontSize: 15.sp, color: AppColors.kWhiteColor),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
