class RouteModel {
  String id = '';
  String numberPlate = '';
  String dateTime = '';
  String entryPoint = '';
  String endPoint = '';

  RouteModel.empty();

  RouteModel({required this.id, required this.numberPlate, required this.dateTime, required this.entryPoint, required this.endPoint});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'] ?? '',
      numberPlate: json['numberPlate'] ?? '',
      dateTime: json['dateTime'] ?? '',
      entryPoint: json['entryPoint'] ?? '',
      endPoint: json['endPoint'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberPlate': numberPlate,
      'dateTime': dateTime,
      'entryPoint': entryPoint,
      'endPoint' : endPoint,
    };
  }
}
