import 'package:flutter/material.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:password_manager_app/models/credential.dart';
import 'package:password_manager_app/services/services.dart';
import 'package:password_manager_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddPasswordPage extends StatelessWidget {
  AddPasswordPage({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: const BoxDecoration(
            color: kMainColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 36.0, 24.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IosBackButton(
                        onBackButtonPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Text(
                        "Add a new credential",
                        style: kSecondaryTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Title",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "write here title",
                              onChangedAction: (s) {},
                              icon: Icons.title,
                              controller: _titleController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Email/Username",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Write Here email or username",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _usernameController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Password",
                                style: kThirdTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PasswordInput(
                                      hintText: "password",
                                      onChangedAction: (s) {},
                                      controller: _passwordController,
                                    ),
                                  ),
                                  RoundedSquareButton(
                                    buttonIcon: Icons.create,
                                    buttonColor: kButtonColor,
                                    onPressedAction: () {
                                      _passwordController.text =
                                          PasswordGenerator
                                              .generateRandomString();
                                    },
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Use the button to create an unbreakable password!",
                                style: TextStyle(
                                  color: Color(0xFFB2AEBA),
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Category",
                                style: kThirdTextStyle,
                              ),
                            ),
                            CustomDropDownButton(
                              items: kPasswordCategories,
                              onChangedAction: (newValue) {
                                value = newValue ?? 'Other';
                                _categoryController.text = newValue ?? 'Other';
                                print(_categoryController.value.text);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Notes",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: 'Write here note',
                              onChangedAction: (newValue) {},
                              icon: Icons.notes,
                              controller: _notesController,
                            ),
                            MainButton(
                              buttonColor: kButtonColor,
                              buttonText: "Add Credential",
                              onPressed: () async {
                                String title = _titleController.text;
                                String email = _usernameController.text;
                                String password = _passwordController.text;
                                String category =
                                    _categoryController.value.text;
                                print(category);
                                String notes = _notesController.text;
                                if (title == '' ||
                                    email == '' ||
                                    password == '') {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CustomAlertDialog(
                                      dialogTitle: 'Invalid Input!',
                                      dialogBody:
                                          'you have to fill all the required fields!',
                                    ),
                                    barrierDismissible: false,
                                  );
                                } else {
                                  Credential credential = Credential(
                                    title: title,
                                    email: email,
                                    password: password,
                                    category: category,
                                    notes: notes,
                                    userName: Provider.of<UserModel>(context,
                                            listen: false)
                                        .currentUser!
                                        .userName,
                                  );
                                  bool isSuccessful =
                                      await Provider.of<CredentialsModel>(
                                              context,
                                              listen: false)
                                          .createNewCredential(credential);
                                  if (isSuccessful) {
                                    // TODO show a snackbar when the the operation succeeds
                                    CustomSnackBars.showCustomSnackBar(context,
                                        'Adding a credential succeeded');
                                  } else {
                                    // TODO show a snackbar when the the operation fails
                                    CustomSnackBars.showCustomSnackBar(context,
                                        'This credential already exists!');
                                  }
                                  Navigator.of(context).pop();
                                }
                              },
                              buttonTextColor: kMainColor,
                              splashHighlightColor: Colors.indigo,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
