import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/controllers/home_screen_controller.dart';
import 'package:toll_calculator/ui/widgets/main_button_widget.dart';
import 'package:toll_calculator/utils/extensions/date_extension.dart';

import '../../utils/app_colors.dart';
import '../widgets/app_bar_widgets.dart';
import '../widgets/interchange_dropdown.dart';
import '../widgets/text_field_widget.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const AppBarWidget(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.r),
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.tabOpacity.value,
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            controller.onTabChange(entryPoint: true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 35.w),
                            decoration: BoxDecoration(
                                color: controller.isEntryPoint.value ? AppColors.kPrimaryColor : AppColors.kTransparentColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: AppColors.kPrimaryColor)),
                            child: Text(
                              'Entry',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: controller.isEntryPoint.value ? AppColors.kWhiteColor : AppColors.kTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            controller.onTabChange(entryPoint: false);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 35.w),
                            decoration: BoxDecoration(
                                color: controller.isEntryPoint.value ? AppColors.kTransparentColor : AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: AppColors.kPrimaryColor)),
                            child: Text(
                              'Exit',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: controller.isEntryPoint.value ? AppColors.kTextColor : AppColors.kWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  '${controller.isEntryPoint.value ? 'Entry' : 'Exit'} Interchange',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => InterchangeDropdown(
                    selectedInterchange: controller.currentWorkingInterchange.value.obs,
                    onItemSelect: controller.onInterchangeSelection,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Number Plate',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(height: 5.h),
                TextFieldWidget(
                  focusNode: controller.numPlateFC,
                  textEditingController: controller.numPlateTEController,
                  hintText: 'ABC-123',
                  onChange: controller.onPlateNumChange,
                  maxLength: 7,
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => Visibility(
                    visible: controller.showErrorMessage.value,
                    child: Text(
                      'Invalid number plate',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: AppColors.kRedColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Date Time',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, height: 1),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedTime = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AdoptiveCalendar(
                          action: true,
                          initialDate: DateTime.now(),
                          fontColor: AppColors.kTextColor,
                          selectedColor: AppColors.kPrimaryColor,
                        );
                      },
                    );
                    if (selectedTime != null) {
                      controller.dateTimeTEController.text = selectedTime.toString().convertToGeneralFormat();
                    }
                  },
                  child: TextFieldWidget(
                    focusNode: controller.dateTimeFC,
                    textEditingController: controller.dateTimeTEController,
                    hintText: '22/09/2024 10:34 PM',
                    isEnabled: false,
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => MainButtonWidget(
                    onTap: controller.onSubmitPressed,
                    child: controller.isSubmitting.value
                        ? SizedBox(
                            width: 20.w,
                            height: 17.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              color: AppColors.kWhiteColor,
                            ),
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(color: AppColors.kWhiteColor, fontSize: 15.sp),
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
