import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alexatek/models/collection_objects.dart';
import 'package:alexatek/models/connected_objects.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

String websiteUrl = "45.147.96.149:8000";

class AuthMethods {

  Future<User?> getUserDetails() async {
    var uid = "tutu";
    var email = "tutu@tutu.com";

    ConnectedObjects obj1 = const ConnectedObjects(name: "lampe 1", uid: "tutu 1", type: "lampe");
    ConnectedObjects obj2 = const ConnectedObjects(name: "porte 1", uid: "tutu 1", type: "porte");
    ConnectedObjects obj3 = const ConnectedObjects(name: "lampe 2", uid: "tutu 1", type: "lampe");
    ConnectedObjects obj4 = const ConnectedObjects(name: "lampe 3", uid: "tutu 1", type: "lampe");
    ConnectedObjects obj5 = const ConnectedObjects(name: "thermometre 1", uid: "tutu 1", type: "thermo");
    List<ConnectedObjects> listObj = <ConnectedObjects>[];
    listObj.add(obj1);
    listObj.add(obj2);
    listObj.add(obj3);
    listObj.add(obj4);
    listObj.add(obj5);

    CollectionObjects coll1 = CollectionObjects(name: "Collection 1", uid: "tutu 1", listObject: listObj);
    CollectionObjects coll2 = CollectionObjects(name: "Collection 2", uid: "tutu 2", listObject: listObj);
    List<CollectionObjects> listCollection = <CollectionObjects>[];
    listCollection.add(coll1);
    listCollection.add(coll2);

    final User user = User(
      name: "John",
      surname: "Doe",
      email: email,
      group: 0,
      listObject: listObj,
      listCollection: listCollection,
    );

    return user;
  }

/*  Future<model.User?> getSpecificUserDetails(String uid) async {
    final DocumentSnapshot<Object?> documentSnapshot =
        await _firestore.collection('users').doc(uid).get();
    return model.User.fromSnap(documentSnapshot);
  }*/

/*  Future<List<model.User>?> getUserListByUsername(String username) async {
    final QuerySnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();
    //List<model.User> listUser = documentSnapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => model.User.fromSnap(doc)).toList();
    //listUser.sort((model.User a, model.User b) => a.username.compareTo(b.username));
    listUser = listUser.reversed.toList();
    return listUser;
  }*/


/*  Future<http.Response> registerUser() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }*/

  Future<String> registerUser({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String group,
  }) async {
    String res = "Internal unknown error.";
    try {
      if (name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // TODO: Register User
        print("tutu");
        final queryParameter = jsonEncode({
          "name": name,
          "surname": surname,
          "email": email,
          "password": password,
          "group": 0,
        });
        print(queryParameter);
        final requestHeaders = {
          'Content-type': 'application/json',
        };
        print(requestHeaders);

        final uri = Uri.http(websiteUrl, "/user/");
        print(uri);
        final response = await http.post(uri, headers: requestHeaders, body: queryParameter);
        print(response);

        if (response.statusCode == 200) {
          User newUser = User.fromJson(jsonDecode(response.body));
          print(newUser.name);
          res = "Success";
        } else if (response.statusCode == 422) {
          res = "Validation error";
        } else {
          res = "Server error";
        }
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
        // TODO: Login User

        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
/*
  Future<String> updateUser({
    String? username,
    String? bio,
    Uint8List? profilePicture,
  }) async {
    String res = "Internal unknown error.";
    try {
      final User currentUser = _auth.currentUser!;

      if (username != "") {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .update(<String, String?>{'username': username});
        res = "Success";
      }
      if (bio != "") {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .update(<String, String?>{'bio': bio});
        res = "Success";
      }
      if (username == "" && bio == "") {
        res = "Please enter at least a field";
      }

      await currentUser.reload();
    } on FirebaseAuthException catch (err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> deleteUser({
    String? userUid,
  }) async {
    String res = "Internal unknown error.";
    try {
      await _firestore.collection('users').doc(_auth.currentUser?.uid).delete();
      await _auth.currentUser?.delete();
      res = 'success';
    } on FirebaseAuthException catch (err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  */
}
