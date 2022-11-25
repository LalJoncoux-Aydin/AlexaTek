import 'package:alexatek/models/collection_objects.dart';

import 'connected_objects.dart';

class User {
  final String name;
  final String surname;
  final String email;
  final int group;
  final List<ConnectedObjects>? listObject;
  final List<CollectionObjects>? listCollection;

  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.group,
    this.listObject,
    this.listCollection,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      group: json['group'],
    );
  }
}
