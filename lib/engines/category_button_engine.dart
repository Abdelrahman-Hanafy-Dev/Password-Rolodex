import 'package:flutter/material.dart';

class CategoryButtonEngine with ChangeNotifier {
  String? _value;

  void changeValue(String newValue) {
    _value = newValue;
    notifyListeners();
  }

  String? get value => _value;

  set value(String? newValue) => _value = newValue;
}
