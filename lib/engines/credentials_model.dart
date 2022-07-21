import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:password_manager_app/database/credentials_database.dart';
import 'package:password_manager_app/models/models.dart';

class CredentialsModel with ChangeNotifier {
  List<Credential> _userCredentials = [];

  Future<bool> createNewCredential(Credential credential) async {
    bool isSuccessful =
        await CredentialsDatabase.instance.createCredential(credential);

    if (isSuccessful) {
      getCredentials(credential.userName);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getCredentials(String username) async {
    _userCredentials =
        await CredentialsDatabase.instance.getAllCredentials(username);
    notifyListeners();
  }

  Future<void> getCredentialsByCategory(
      String username, String category) async {
    _userCredentials = await CredentialsDatabase.instance
        .getCredentialsByCategory(username, category);
    notifyListeners();
  }

  Future<void> getCredentialsBySearch(String search, String username) async {
    _userCredentials = await CredentialsDatabase.instance
        .getCredentialsBySearch(search, username);
    notifyListeners();
  }

  Future<void> deleteCredential(String title, String email, String username,
      Credential credential) async {
    await CredentialsDatabase.instance.deleteCredential(title, email, username);
    _userCredentials.remove(credential);
    notifyListeners();
  }

  void resetCredentialsList() {
    _userCredentials = [];
  }

  UnmodifiableListView<Credential> get userCredentials =>
      UnmodifiableListView(_userCredentials);
}
