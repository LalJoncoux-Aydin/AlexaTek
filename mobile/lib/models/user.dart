import 'package:alexatek/models/collection_objects.dart';

import 'connected_objects.dart';

class User {
  final String name;
  final String surname;
  final String email;
  final int group;
  late List<ConnectedObjects>? listObject;
  late List<CollectionObjects>? listCollection;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.group,
    this.listObject,
    this.listCollection,
  });

  void setListsUser(listObject, listCollection) {
    this.listObject = listObject;
    this.listCollection = listCollection;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      group: json['group'],
    );
  }
}
