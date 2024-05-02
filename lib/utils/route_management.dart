import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/bindings/login_screen_bindings.dart';
import 'package:toll_calculator/bindings/splash_screen_bindings.dart';
import 'package:toll_calculator/ui/screens/home_screen.dart';
import 'package:toll_calculator/ui/screens/login_screen.dart';

import '../bindings/home_screen_bindings.dart';
import '../ui/screens/splash_screen.dart';

class RouteNames {
  static const String kSplashScreenRoute = '/';
  static const String kLoginScreenRoute = '/LOGIN_ROUTE';
  static const String kHomeScreenRoute = '/HOME_SCREEN_ROUTE';
}


class RouteManagement {

  static List<GetPage> getRoutes(){
    return [
      GetPage(
        name: RouteNames.kSplashScreenRoute,
        page: () => const SplashScreen(),
        binding: SplashScreenBindings(),
        curve: Curves.easeInOut,
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: RouteNames.kLoginScreenRoute,
        page: () => const LoginScreen(),
        binding: LoginScreenBindings(),
        curve: Curves.easeInOut,
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: RouteNames.kHomeScreenRoute,
        page: () => const HomeScreen(),
        binding: HomeScreenBindings(),
        curve: Curves.easeInOut,
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ];
  }
}