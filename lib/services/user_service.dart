import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  UserService._internal();

  factory UserService() => _instance;

  Future<dynamic> loginUser({required String email, required String password}) async {
    try {
      User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection(Constants.kUserNode).doc(user.uid).get();
        Map<String, dynamic>? mapData = documentSnapshot.data();
        if (mapData != null) {
          UserModel userModel = UserModel.fromJson(mapData);
          return userModel;
        }
      }
    } catch (exception) {
      if (exception is FirebaseException && exception.message == "There is no user record corresponding to this identifier. The user may have been deleted.") {
        return "User with '$email' does not exist!";
      } else if (exception is FirebaseException && exception.message == "The supplied auth credential is incorrect, malformed or has expired.") {
        return "Incorrect Email or Password!";
      } else if (exception is FirebaseException && exception.message == "The email address is badly formatted.") {
        return "Invalid Email!";
      }
    }
    return Constants.kSomethingWentWrong;
  }

  Future updateUserInterchange({required UserModel userModel}) async {
    await FirebaseFirestore.instance.collection(Constants.kUserNode).doc(userModel.userId).update({"workingInterChange": userModel.workingInterChange});
  }
}
