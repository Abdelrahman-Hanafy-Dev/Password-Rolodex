import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/widgets/widgets.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: TextButton(
          child: const Text('click me!'),
          onPressed: () {
            CustomSnackBars.showCustomSnackBar(context, 'My first snackBar!');
          },
        ),
      ),
    );
  }
}
