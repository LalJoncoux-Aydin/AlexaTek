import 'package:alexatek/models/connected_objects.dart';

class CollectionObjects {
  const CollectionObjects({
    required this.name,
    required this.uid,
    required this.listObject,
  });
  final String name;
  final String uid;
  final List<ConnectedObjects> listObject;

  List<Map<String, dynamic>> listObjToJson() {
    List<Map<String, dynamic>> listPrint = <Map<String, dynamic>>[];

    for (var element in listObject) {
      listPrint.add(element.toJson());
    }
    return listPrint;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "uid": uid,
    "listObject": listObjToJson(),
  };
}