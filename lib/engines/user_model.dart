import 'package:flutter/material.dart';
import 'package:password_manager_app/database/credentials_database.dart';
import 'package:password_manager_app/models/models.dart';

class UserModel with ChangeNotifier {
  User? _currentUser;

  Future<bool> login(String username, String password) async {
    User? userCheck = await CredentialsDatabase.instance.getUser(username);
    if (userCheck == null) {
      return false;
    } else {
      if (userCheck.password == password) {
        _currentUser = userCheck;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> register(User user) async {
    bool isSuccessful = await CredentialsDatabase.instance.createUser(user);
    if (isSuccessful) {
      _currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> forgotPassword(String username) async {
    User? userCheck = await CredentialsDatabase.instance.getUser(username);

    if (userCheck == null) {
      return false;
    }
    _currentUser = userCheck;
    notifyListeners();
    return true;
  }

  Future<bool> changePassword(String newPassword) async {
    print(_currentUser);
    User? newUser = _currentUser?.copy(password: newPassword);

    bool isSuccessful =
        await CredentialsDatabase.instance.changeUserPassword(newUser!);
    return isSuccessful;
  }

  void resetUser() {
    _currentUser = null;
  }

  User? get currentUser => _currentUser;
}
