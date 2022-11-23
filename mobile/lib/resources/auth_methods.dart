import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alexatek/models/user.dart' as model;
import 'package:alexatek/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User getUserDetails() {
    User currentUser = _auth.currentUser!;

    /*DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();*/

    return currentUser;
  }

  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res = "Internal unknown error.";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty) {
        model.User user = model.User(
          uid: "1",
          email: email,
        );

    //    await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());

        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch(err) {
      if (err.code == 'invalid-email') {
        return "Email format is invalid.";
      }
      if (err.code == 'weak-password') {
        return "Password should be at least 6 characters.";
      }
      if (err.code == 'email-already-in-use') {
        return "Email address is already in use by another account.";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Credentials are incorrect.";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
/*        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );*/
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch(err) {
      if (err.code == 'invalid-email') {
        return "Email format is invalid.";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
   // await _auth.signOut();
  }
}
