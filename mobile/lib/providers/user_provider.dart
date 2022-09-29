import 'package:flutter/material.dart';
import 'package:instatek/models/user.dart';
import 'package:instatek/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    // To change
    User? user = _user;
    _user = user;
    notifyListeners();
  }
}