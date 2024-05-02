import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toll_calculator/models/user_model.dart';

class SessionManagement {
  late final SharedPreferences _sharedPreferences;

  static final SessionManagement _instance = SessionManagement._internal();

  factory SessionManagement() {
    return _instance;
  }

  SessionManagement._internal();

  final String _userData = "USER_DATA";
  final String _isLogin = "IS_LOGIN";

  Future initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> updateLoginStatus({required bool isLogin}) async {
    return await _sharedPreferences.setBool(_isLogin, isLogin);
  }

  Future<bool> isUserLogin() async {
    return _sharedPreferences.getBool(_isLogin) ?? false;
  }

  Future<bool> updateUserData({required UserModel userModel}) async {
    return await _sharedPreferences.setString(_userData, jsonEncode(userModel.toJson()));
  }

  Future<UserModel> getUserData() async {
    return UserModel.fromJson(jsonDecode(_sharedPreferences.getString(_userData) ?? '{}'));
  }
}
