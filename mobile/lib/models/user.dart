import 'package:alexatek/models/collection_objects.dart';

import 'connected_objects.dart';

class User {
  const User({
    required this.email,
    required this.uid,
    required this.listObject,
    required this.listCollection,
  });
  final String email;
  final String uid;
  final List<ConnectedObjects> listObject;
  final List<CollectionObjects> listCollection;

  List<Map<String, dynamic>> listObjToJson() {
    List<Map<String, dynamic>> listPrint = <Map<String, dynamic>>[];

    for (var element in listObject) {
      listPrint.add(element.toJson());
    }
    return listPrint;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "uid": uid,
    "email": email,
    "listObject": listObjToJson(),
  };
}
