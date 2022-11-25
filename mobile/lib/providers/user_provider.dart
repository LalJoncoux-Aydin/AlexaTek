import 'package:flutter/material.dart';
import 'package:alexatek/methods/auth_methods.dart';
import 'package:alexatek/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User _user;
  late String _token = "";
  final AuthMethods _authMethods = AuthMethods();
  late bool isUser = false;

  User get getUser => _user;
  String get getToken => _token;

  Future<void> setupUser(User newUser) async {
    _user = newUser;
    isUser = true;
    notifyListeners();
  }

  Future<void> setupToken(String token) async {
    _token = token;
    notifyListeners();
  }

  Future<void> refreshUser() async {
    final User? user = await _authMethods.getUserDetails();

    if (user != null) {
      _user = user;
      notifyListeners();
      isUser = true;
    } else {
      isUser = false;
    }
  }
}