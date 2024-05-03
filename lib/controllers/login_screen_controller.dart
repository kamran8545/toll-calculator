import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/models/user_model.dart';
import 'package:toll_calculator/services/user_service.dart';
import 'package:toll_calculator/utils/common_code.dart';
import 'package:toll_calculator/utils/route_management.dart';
import 'package:toll_calculator/utils/session_management.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();

  FocusNode emailFC = FocusNode();
  FocusNode passwordFC = FocusNode();

  RxBool isLoading = false.obs;

  void onLoginPressed() async {
    if (isLoading.value) {
      return;
    }

    if (emailTEController.text.trim().isEmpty) {
      CommonCode.showToastMessage(message: 'Enter email address');
    } else if (passwordTEController.text.trim().isEmpty) {
      CommonCode.showToastMessage(message: 'Enter password');
    } else {
      isLoading.value = true;
      dynamic response = await UserService().loginUser(email: emailTEController.text.trim(), password: passwordTEController.text.trim());
      isLoading.value = false;
      if (response is UserModel) {
        SessionManagement sessionManagement = Get.find<SessionManagement>();
        sessionManagement.updateLoginStatus(isLogin: true);
        sessionManagement.updateUserData(userModel: response);
        Get.offAllNamed(RouteNames.kHomeScreenRoute);
      } else if (response is String) {
        CommonCode.showToastMessage(message: response);
      }
    }
  }
}
