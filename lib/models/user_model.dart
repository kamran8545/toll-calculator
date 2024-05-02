class UserModel {
  String userId = '';
  String userEmail = '';
  String workingInterChange = '';

  UserModel.empty();

  UserModel({required this.userId, required this.userEmail, required this.workingInterChange});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      userEmail: json['userEmail'] ?? '',
      workingInterChange: json['workingInterChange'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'userId' : userId,
      'userEmail' : userEmail,
      'workingInterChange' : workingInterChange,
    };
  }
}
