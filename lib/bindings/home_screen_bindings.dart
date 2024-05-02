import 'package:get/get.dart';
import 'package:toll_calculator/controllers/home_screen_controller.dart';

class HomeScreenBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }

}