import 'dart:typed_data';
import 'package:alexatek/models/connected_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alexatek/models/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User?> getUserDetails() async {
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

    final model.User user = model.User(
      uid: uid,
      email: email,
      listObject: listObj,
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

  Future<bool> usernameDoesntExist(dynamic username) async {
    final QuerySnapshot<Object?> querySnapshot =
        await _firestore.collection('users').get();

    final List<Object?> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Object?> doc) => doc.data())
        .toList();
    for (Object? user in allData) {
      final String userStr = user.toString();
      final String usernameOffset =
          userStr.substring(userStr.indexOf("username: "));
      final String usernameOld = usernameOffset.substring(
        usernameOffset.indexOf(" ") + 1,
        (!usernameOffset.contains(","))
            ? usernameOffset.indexOf("}")
            : usernameOffset.indexOf(","),
      );
      if (username == usernameOld) {
        return true;
      }
    }
    return false;
  }

  Future<bool> emailDoesntExist(dynamic email) async {
    final QuerySnapshot<Object?> querySnapshot =
        await _firestore.collection('users').get();

    final List<Object?> allData = querySnapshot.docs
        .map((QueryDocumentSnapshot<Object?> doc) => doc.data())
        .toList();
    for (Object? user in allData) {
      final String userStr = user.toString();
      final String usernameOffset =
          userStr.substring(userStr.indexOf("email: "));
      final String usernameOld = usernameOffset.substring(
        usernameOffset.indexOf(" ") + 1,
        (!usernameOffset.contains(","))
            ? usernameOffset.indexOf("}")
            : usernameOffset.indexOf(","),
      );
      if (email == usernameOld) {
        return false;
      }
    }
    return true;
  }

  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    String res = "Internal unknown error.";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // TODO: Register User

        res = "Success";
      } else {
        res = "Please enter all the fields";
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

  Future<String> addFollowers({
    String? userUid,
    String? ownerUid,
  }) async {
    String res = "Internal unknown error.";
    try {
      // Add followers in owner user
      await _firestore.collection('users').doc(ownerUid).update( <String, dynamic>{
        'following': FieldValue.arrayUnion(<dynamic>[userUid as dynamic])
      });
      // Add following in visited user
      await _firestore.collection('users').doc(userUid).update(<String, dynamic>{
        'followers': FieldValue.arrayUnion(<dynamic>[ownerUid as dynamic])
      });
      res = "success";
    } on FirebaseAuthException catch (err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
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

  Future<String> removeFollowers({
    String? userUid,
    String? ownerUid,
  }) async {
    String res = "Internal unknown error.";
    try {
      // Add followers in owner user
      await _firestore.collection('users').doc(ownerUid).update( <String, dynamic>{
        'following': FieldValue.arrayRemove(<dynamic>[userUid as dynamic])
      });
      // Add following in visited user
      await _firestore.collection('users').doc(userUid).update(<String, dynamic>{
        'followers': FieldValue.arrayRemove(<dynamic>[ownerUid as dynamic])
      });
      res = "success";
    } on FirebaseAuthException catch (err) {
      res = err.code;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
