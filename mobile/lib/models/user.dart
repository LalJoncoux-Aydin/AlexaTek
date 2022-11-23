import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User({
    required this.email,
    required this.uid,
  });
  final String email;
  final String uid;

  static User fromSnap(DocumentSnapshot<Object?> snap) {
    final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "uid": uid,
        "email": email,
      };
}
