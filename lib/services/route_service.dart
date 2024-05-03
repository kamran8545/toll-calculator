import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toll_calculator/models/route_model.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';

class RouteService {
  static final RouteService _instance = RouteService._internal();

  RouteService._internal();

  factory RouteService() => _instance;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<bool> addRoute({required RouteModel routeModel}) async {
    var randomId = const Uuid().v1().toString();
    routeModel.id = randomId;
    await _firebaseFireStore.collection(Constants.kRoutesNode).doc(randomId).set(routeModel.toJson());
    return true;
  }

  Future<RouteModel> getRouteByNumPlate({required String numPlate}) async {
    QuerySnapshot querySnapshot = await _firebaseFireStore.collection(Constants.kRoutesNode).where('numberPlate', isEqualTo: numPlate).where('endPoint', isEqualTo: '').get();
    List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs;
    if (queryDocumentSnapshot.isNotEmpty) {
      Map<String, dynamic> data = queryDocumentSnapshot.first.data() as Map<String, dynamic>;
      return RouteModel.fromJson(data);
    } else {
      return RouteModel.empty();
    }
  }

  Future updateRoute({required RouteModel routeModel}) async {
    await FirebaseFirestore.instance.collection(Constants.kRoutesNode).doc(routeModel.id).update({"endPoint": routeModel.endPoint});
  }
}
