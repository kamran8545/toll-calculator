import 'package:toll_calculator/models/interchange_model.dart';

class Constants {
  
  static List<InterchangeModel> interchangeList = [
    InterchangeModel(interchangeName: 'Zero Point', kiloMeter: 0),
    InterchangeModel(interchangeName: 'NS Interchange', kiloMeter: 5),
    InterchangeModel(interchangeName: 'Ph4 Interchange', kiloMeter: 10),
    InterchangeModel(interchangeName: 'Ferozpur Interchange', kiloMeter: 17),
    InterchangeModel(interchangeName: 'Lake City Interchange', kiloMeter: 24),
    InterchangeModel(interchangeName: 'Raiwand Interchange', kiloMeter: 29),
    InterchangeModel(interchangeName: 'Bahria Interchange', kiloMeter: 34),
  ];

  /// Font Family
  static const String kProtofoFonts = 'Protofo';

  /// Firebase Nodes
  static const String kUserNode = 'users';
  static const String kRoutesNode = 'routes';

  /// Error messages
  static const String kSomethingWentWrong = 'Something went wrong, please try again later!';
}