import 'package:get/get.dart';
import 'package:toll_calculator/controllers/login_screen_controller.dart';

import '../utils/session_management.dart';

class LoginScreenBindings extends Bindings{
  @override
  void dependencies() async{
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => SessionManagement());
  }
}