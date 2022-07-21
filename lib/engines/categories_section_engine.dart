import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';

class CategoriesEngine with ChangeNotifier {
  int _currentCategory = -1;

  set currentCategory(int currentCategory) {
    if (!(currentCategory >= kPasswordCategories.length ||
        currentCategory < -1)) {
      _currentCategory = currentCategory;
      notifyListeners();
    }
  }

  int get currentCategory => _currentCategory;
}
