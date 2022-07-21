import 'package:flutter/material.dart';

class LoadingEngine with ChangeNotifier {
  bool _loginLoading = false;
  bool _registerLoading = false;
  bool _addCredentialLoading = false;

  void toggleLoginLoading() {
    _loginLoading = !_loginLoading;
  }

  void toggleRegisterLoading() {
    _registerLoading = !_registerLoading;
  }

  void toggleAddCredentialLoading() {
    _addCredentialLoading = !_addCredentialLoading;
  }

  bool get registerLoading => _registerLoading;

  bool get loginLoading => _loginLoading;

  bool get addCredentialLoading => _addCredentialLoading;
}
