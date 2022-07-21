import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogBody;

  const CustomAlertDialog(
      {Key? key, required this.dialogTitle, required this.dialogBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: Text(
        dialogBody,
        style: const TextStyle(fontSize: 20.0, color: kSecondaryTextColor),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 20.0, color: kDarkMainColor),
          ),
        ),
      ],
      backgroundColor: kButtonColor,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      titleTextStyle: const TextStyle(
        color: kMainColor,
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
