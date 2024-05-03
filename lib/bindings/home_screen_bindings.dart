import 'package:get/get.dart';
import 'package:toll_calculator/controllers/home_screen_controller.dart';

import '../utils/session_management.dart';

class HomeScreenBindings extends Bindings{
  @override
  void dependencies() async{
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => SessionManagement());
  }

}