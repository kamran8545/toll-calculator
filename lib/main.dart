import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/utils/constants.dart';
import 'package:toll_calculator/utils/route_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // child: const MyHomePage(title: 'Toll Calculator'),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Toll Calculator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: Constants.kProtofoFonts,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RouteNames.kSplashScreenRoute,
          getPages: RouteManagement.getRoutes(),
        );
      },
    );
  }
}