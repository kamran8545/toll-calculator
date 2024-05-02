import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class CommonCode{

  static void showToastMessage({required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.kPrimaryColor,
        textColor: AppColors.kWhiteColor,
        fontSize: 16.sp
    );
  }

}