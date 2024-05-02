import 'package:get/get.dart';
import 'package:toll_calculator/controllers/login_screen_controller.dart';

class LoginScreenBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
  }
}