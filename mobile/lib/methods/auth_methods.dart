import 'dart:convert';
import 'dart:io';
import 'package:alexatek/models/collection_objects.dart';
import 'package:alexatek/models/module.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

String websiteUrl = "http://45.147.96.149:8000";

class AuthMethods {
  Future<User?> getUserDetails(String token) async {
    http.Response response = await http.get(
      Uri.parse("$websiteUrl/user/get"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token
      },
    );
    if (response.statusCode == 200) {
      Module obj1 = Module(name: "lampe 1", id: 1, value: "0");
      Module obj2 =  Module(name: "porte 1", id: 2, value: "0");
      Module obj3 =  Module(name: "lampe 2", id: 3, value: "0");
      Module obj4 =  Module(name: "lampe 3", id: 4, value: "0");
      Module obj5 =  Module(name: "thermometre 1", id: 5, value: "0");
      List<Module> listObj = <Module>[];
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

      final User user = User.fromJson(jsonDecode(response.body));
      user.setUserCollection(listCollection);

      return user;
    } else {
      return null;
    }
  }

  Future<List<Module>> getModules(String token) async {
    http.Response response = await http.get(
      Uri.parse("$websiteUrl/arduino/get_module"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token
      },
    );
    http.Response responseSave = await http.get(
      Uri.parse("$websiteUrl/save/get"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token
      },
    );
    var saveValues = jsonDecode(responseSave.body);
    print(saveValues);

    final List<Module> listModule = [];
    Module newModule = Module.fromJson(jsonDecode(response.body)["modules"][0]);
    if (saveValues["detail"] != "No saves found") {
      newModule.value = jsonDecode(responseSave.body)["led"].toString();
    }
    listModule.add(newModule);
    Module newModule2 = Module.fromJson(jsonDecode(response.body)["modules"][1]);
    if (saveValues["detail"] != "No saves found") {
      newModule2.value = "${jsonDecode(responseSave.body)["r"]},${jsonDecode(responseSave.body)["g"]},${jsonDecode(responseSave.body)["b"]}";
    }
    listModule.add(newModule2);
    Module newModule3 = Module.fromJson(jsonDecode(response.body)["modules"][2]);
    if (saveValues["detail"] != "No saves found") {
      newModule3.value = jsonDecode(responseSave.body)["servo"].toString();
    }
    listModule.add(newModule3);

    return listModule;
  }


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
        http.Response response = await http.post(
          Uri.parse("$websiteUrl/user"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "surname": surname,
            "email": email,
            "password": password,
            "group": 0,
          }),
        );

        if (response.statusCode == 200) {
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
    String res = "";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        http.Response response = await http.post(
          Uri.parse("$websiteUrl/auth/login"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "email": email,
            "password": password,
          }),
        );

        if (response.statusCode == 200) {
          res = jsonDecode(response.body)['token'];
        } else if (response.statusCode == 422) {
          res = "credentials-error";
        } else {
          res = "server-error";
        }
      }
    } catch (err) {
      res = "server-error";
    }
    return res;
  }

  Future<String> setLedValue({
    required int id,
    required String value,
    required String token,
  }) async {
    String res = "";
    List<String> listValue = [];
    listValue.add(value);
    try {
      http.Response response = await http.post(
        Uri.parse("$websiteUrl/arduino/action"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          'X-API-KEY': token,
        },
        body: jsonEncode(<String, dynamic>{
          "id": "$id",
          "args": listValue,
        }),
      );

      if (response.statusCode == 200) {
        res = "Success";

        http.Response responseSave = await http.get(
          Uri.parse("$websiteUrl/save/get"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token
          },
        );
        var lastResponseSave = jsonDecode(responseSave.body);

        http.Response responseSavePost = await http.post(
          Uri.parse("$websiteUrl/save"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token,
          },
          body: jsonEncode(<String, dynamic>{
            "led": int.parse(value),
            "r": lastResponseSave["r"],
            "g": lastResponseSave["g"],
            "b": lastResponseSave["b"],
            "servo": lastResponseSave["servo"],
          }),
        );
      } else if (response.statusCode == 422) {
        res = "credentials-error";
      } else {
        res = "server-error";
      }
    } catch (err) {
      res = "server-error";
    }
    return res;
  }

  Future<String> setRgbValue({
    required int id,
    required String value1,
    required String value2,
    required String value3,
    required String token,
  }) async {
    String res = "";
    List<String> listValue = [];
    listValue.add(value1);
    listValue.add(value2);
    listValue.add(value3);
    try {
      http.Response response = await http.post(
        Uri.parse("$websiteUrl/arduino/action"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          'X-API-KEY': token,
        },
        body: jsonEncode(<String, dynamic>{
          "id": "$id",
          "args": listValue,
        }),
      );

      if (response.statusCode == 200) {
        res = "Success";

        http.Response responseSave = await http.get(
          Uri.parse("$websiteUrl/save/get"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token
          },
        );
        var lastResponseSave = jsonDecode(responseSave.body);
        print(lastResponseSave);

        http.Response responseSavePost = await http.post(
          Uri.parse("$websiteUrl/save"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token,
          },
          body: jsonEncode(<String, dynamic>{
            "led": lastResponseSave["led"],
            "r": int.parse(value1),
            "g": int.parse(value2),
            "b": int.parse(value3),
            "servo": lastResponseSave["servo"],
          }),
        );
      } else if (response.statusCode == 422) {
        res = "credentials-error";
      } else {
        res = "server-error";
      }
    } catch (err) {
      res = "server-error";
    }
    return res;
  }

  Future<String> resetSavedValues({
  required String token,
  }) async {
    var res = "Error";

    await http.post(
      Uri.parse("$websiteUrl/arduino/action"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token,
      },
      body: jsonEncode(<String, dynamic>{
        "id": "1",
        "args": ["0"],
      }),
    );

    await http.post(
      Uri.parse("$websiteUrl/arduino/action"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token,
      },
      body: jsonEncode(<String, dynamic>{
        "id": "2",
        "args": ["0", "0", "0"],
      }),
    );

    await http.post(
      Uri.parse("$websiteUrl/arduino/action"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token,
      },
      body: jsonEncode(<String, dynamic>{
        "id": "3",
        "args": ["0"],
      }),
    );

    http.Response responseSavePost = await http.post(
      Uri.parse("$websiteUrl/save"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-API-KEY': token,
      },
      body: jsonEncode(<String, dynamic>{
        "led": 0,
        "r": 0,
        "g": 0,
        "b": 0,
        "servo": 0,
      }),
    );
    if (responseSavePost.statusCode == 200) {
      res = "Success";
    }
    return res;
  }

  Future<String> setDoorValue({
    required int id,
    required String value,
    required String token,
  }) async {
    String res = "";
    List<String> listValue = [];
    listValue.add(value);
    try {
      http.Response response = await http.post(
        Uri.parse("$websiteUrl/arduino/action"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          'X-API-KEY': token,
        },
        body: jsonEncode(<String, dynamic>{
          "id": "$id",
          "args": listValue,
        }),
      );

      if (response.statusCode == 200) {
        res = "Success";

        http.Response responseSave = await http.get(
          Uri.parse("$websiteUrl/save/get"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token
          },
        );
        var lastResponseSave = jsonDecode(responseSave.body);

        http.Response responseSavePost = await http.post(
          Uri.parse("$websiteUrl/save"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            'X-API-KEY': token,
          },
          body: jsonEncode(<String, dynamic>{
            "led": lastResponseSave["led"],
            "r": lastResponseSave["r"],
            "g": lastResponseSave["g"],
            "b": lastResponseSave["b"],
            "servo": int.parse(value),
          }),
        );
      } else if (response.statusCode == 422) {
        res = "credentials-error";
      } else {
        res = "server-error";
      }
    } catch (err) {
      res = "server-error";
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
