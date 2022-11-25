import 'package:alexatek/models/module.dart';

class CollectionObjects {
  const CollectionObjects({
    required this.name,
    required this.uid,
    required this.listObject,
  });
  final String name;
  final String uid;
  final List<Module> listObject;


  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "uid": uid,
  };
}