import 'package:flutter/material.dart';
import 'package:alexatek/methods/auth_methods.dart';
import 'package:alexatek/models/user.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMethods _authMethods = AuthMethods();
  late bool isUser = false;

  User get getUser => _user;

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