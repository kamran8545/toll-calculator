import 'package:get/get.dart';
import 'package:toll_calculator/controllers/splash_screen_controller.dart';
import 'package:toll_calculator/utils/session_management.dart';

class SplashScreenBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SplashScreenController());

    var session = SessionManagement();
    await session.initSharedPreferences();
    Get.lazyPut(() => session);
  }
}
