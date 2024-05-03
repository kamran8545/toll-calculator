import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toll_calculator/models/user_model.dart';

class SessionManagement {
  static final SessionManagement _instance = SessionManagement._internal();

  factory SessionManagement() {
    return _instance;
  }

  SessionManagement._internal();

  final String _userData = "USER_DATA";
  final String _isLogin = "IS_LOGIN";

  Future<bool> updateLoginStatus({required bool isLogin}) async {
    return await (await SharedPreferences.getInstance()).setBool(_isLogin, isLogin);
  }

  Future<bool> isUserLogin() async {
    return (await SharedPreferences.getInstance()).getBool(_isLogin) ?? false;
  }

  Future<bool> updateUserData({required UserModel userModel}) async {
    return await (await SharedPreferences.getInstance()).setString(_userData, jsonEncode(userModel.toJson()));
  }

  Future<UserModel> getUserData() async {
    return UserModel.fromJson(jsonDecode((await SharedPreferences.getInstance()).getString(_userData) ?? '{}'));
  }

  Future logout()async{
    var session = await SharedPreferences.getInstance();
    await session.setBool(_isLogin, false);
    await session.setString(_userData, jsonEncode({}));
  }
}
