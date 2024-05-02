import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/models/interchange_model.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class InterchangeDropdown extends StatelessWidget {
  final Rx<InterchangeModel> selectedInterchange;
  Function(InterchangeModel interchangeModel) onItemSelect;
  InterchangeDropdown({super.key, required this.onItemSelect, required this.selectedInterchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      height: 35.h,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryLightColor,
        border: Border.all(width: 1.h, color: AppColors.kPrimaryColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton<InterchangeModel>(
            isDense: false,
            isExpanded: true,
            value: selectedInterchange.value,
            style: const TextStyle(color: AppColors.kPrimaryColor),
            items: [
              for (InterchangeModel interchangeModel in Constants.interchangeList)
                DropdownMenuItem<InterchangeModel>(
                  value: interchangeModel,
                  child: Text(
                    interchangeModel.interchangeName,
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
            ],
            onChanged: (InterchangeModel? selectedItem) {
              if (selectedItem != null) {
                selectedInterchange.value = selectedItem;
                onItemSelect(selectedItem);
              }
            },
          ),
        ),
      ),
    );
  }
}
