import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';

class CustomSnackBars {
  static void showCustomSnackBar(BuildContext context, String info) {
    final snackBar = SnackBar(
      content: Text(
        info,
        style: const TextStyle(
          color: kMainColor,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: kButtonColor,
      margin: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
