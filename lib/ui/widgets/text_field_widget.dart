import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<TextInputFormatter> formatter;
  final Function(String updateText)? onChange;
  final FocusNode focusNode;
  final String hintText;
  final bool isEnabled;
  final int maxLength;

  const TextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.hintText,
    this.isEnabled = true,
    this.formatter = const [],
    this.onChange,
    this.maxLength = 10000,
  });

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
      child: TextField(
        inputFormatters: formatter,
        enabled: isEnabled,
        controller: textEditingController,
        focusNode: focusNode,
        obscureText: hintText == '******',
        onChanged: onChange,
        maxLength: maxLength,
        style: const TextStyle(color: AppColors.kTextColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.kTextColor),
          counterText: '',
        ),
      ),
    );
  }
}
