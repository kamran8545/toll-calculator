import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toll_calculator/models/route_model.dart';
import 'package:toll_calculator/models/user_model.dart';
import 'package:toll_calculator/services/route_service.dart';
import 'package:toll_calculator/services/user_service.dart';
import 'package:toll_calculator/utils/constants.dart';
import 'package:toll_calculator/utils/extensions/date_extension.dart';
import 'package:toll_calculator/utils/session_management.dart';

import '../models/interchange_model.dart';

class HomeScreenController extends GetxController {
  SessionManagement sessionManagement = Get.find<SessionManagement>();

  UserModel userModel = UserModel.empty();
  Rx<InterchangeModel> currentWorkingInterchange = Constants.interchangeList.first.obs;

  TextEditingController numPlateTEController = TextEditingController();
  TextEditingController dateTimeTEController = TextEditingController();

  FocusNode numPlateFC = FocusNode();
  FocusNode dateTimeFC = FocusNode();

  Rx<DateTime> routeTime = DateTime.now().obs;
  RxBool showErrorMessage = false.obs, isSubmitting = false.obs, isEntryPoint = true.obs;

  RxDouble tabOpacity = 1.0.obs;

  @override
  void onInit() async {
    dateTimeTEController.text = routeTime.toString().convertToGeneralFormat();
    userModel = await sessionManagement.getUserData();
    currentWorkingInterchange.value = Constants.interchangeList.where((element) => element.interchangeName == userModel.workingInterChange).toList().first;
    super.onInit();
  }

  void onInterchangeSelection(InterchangeModel interchangeModel) async {
    UserModel updateUserModel = UserModel(userId: userModel.userId, userEmail: userModel.userEmail, workingInterChange: interchangeModel.interchangeName);
    await UserService().updateUserInterchange(userModel: updateUserModel);
    sessionManagement.updateUserData(userModel: updateUserModel);
    currentWorkingInterchange.value = interchangeModel;
  }

  void onPlateNumChange(String updatedText) {
    if (updatedText.isEmpty || updatedText.length < 7) {
      showErrorMessage.value = false;
      return;
    }
    var regex = RegExp(r"^[A-Za-z]{3}-[0-9]{3}$");
    showErrorMessage.value = !regex.hasMatch(updatedText);
  }

  void onTabChange({required bool entryPoint}) async {
    tabOpacity.value = 0.0;
    await Future.delayed(const Duration(milliseconds: 400));
    isEntryPoint.value = entryPoint;
    tabOpacity.value = 1.0;
  }

  void onSubmitPressed() async {
    if (showErrorMessage.value || numPlateTEController.text.length < 7) {
      return;
    }
    isSubmitting.value = true;
    if(isEntryPoint.value){
      RouteModel routeModel = RouteModel(
        id: '',
        numberPlate: numPlateTEController.text,
        dateTime: dateTimeTEController.text,
        entryPoint: currentWorkingInterchange.value.interchangeName,
        endPoint: '',
      );
      await RouteService().addRoute(routeModel: routeModel);
      numPlateTEController.text = '';
    }else{
      RouteModel oldRouteModel = await RouteService().getRouteByNumPlate(numPlate: numPlateTEController.text);
      oldRouteModel.endPoint = currentWorkingInterchange.value.interchangeName;
      calculateCharges(routeModel: oldRouteModel);
    }
    isSubmitting.value = false;
  }

  void calculateCharges({required RouteModel routeModel}){
    int baseCharges  = 20;
    double perKMCharges = 0.2;

    double currentCharges = calculateTraveledKM(routeModel: routeModel) * perKMCharges;
    currentCharges = calculateDiscount(routeModel: routeModel, currentCharges: currentCharges);
    currentCharges = weekendCharges(routeModel: routeModel, currentCharges: currentCharges);
    currentCharges += baseCharges;
  }

  int calculateTraveledKM({required RouteModel routeModel}){
    InterchangeModel entryModel = Constants.interchangeList.where((element) => element.interchangeName == routeModel.entryPoint).toList().first;
    InterchangeModel exitModel = Constants.interchangeList.where((element) => element.interchangeName == routeModel.endPoint).toList().first;
    int totalKMTraveled = exitModel.kiloMeter - entryModel.kiloMeter;
    if(totalKMTraveled < 0){
      totalKMTraveled = totalKMTraveled * -1;
    }
    return totalKMTraveled;
  }

  double calculateDiscount({required RouteModel routeModel, required double currentCharges}){
    double evenOddDiscount = 0.1; // 10 percent
    double nationalHolidayDiscount = 0.5; // 50 percent

    DateTime traveledTime = routeModel.dateTime.parseDate();
    if(traveledTime.weekday == 1 || traveledTime.weekday == 3 && int.parse(routeModel.numberPlate[6]) % 2 == 0){
      /// if day is Monday or Wednesday and Vehicle's number plate last digit is even
      currentCharges = currentCharges - currentCharges * evenOddDiscount;
    }else if(traveledTime.weekday == 2 || traveledTime.weekday == 4 && int.parse(routeModel.numberPlate[6]) % 2 != 0){
      /// if day is Tuesday or Thursday and Vehicle's number plate last digit is odd
      currentCharges = currentCharges - currentCharges * evenOddDiscount;
    }else if((traveledTime.day == 23 && traveledTime.month == 3) || (traveledTime.day == 14 && traveledTime.month == 8) || (traveledTime.day == 25 && traveledTime.month == 12)){
      /// holiday discount
      currentCharges = currentCharges - currentCharges * nationalHolidayDiscount;
    }
    return currentCharges;
  }

  double weekendCharges({required RouteModel routeModel, required double currentCharges}){
    double distanceRate = 1.5; // 1.5 times on weekends

    DateTime traveledTime = routeModel.dateTime.parseDate();
    if(traveledTime.weekday == 6 || traveledTime.weekday == 7){
      currentCharges *= distanceRate;
    }
    return currentCharges;
  }
}
