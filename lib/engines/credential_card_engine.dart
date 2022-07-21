import 'package:flutter/material.dart';

class CardEngine with ChangeNotifier {
  bool _shouldDelete = false;

  void toggleFlag() {
    _shouldDelete = !_shouldDelete;
    notifyListeners();
  }

  bool get shouldDelete => _shouldDelete;
}
