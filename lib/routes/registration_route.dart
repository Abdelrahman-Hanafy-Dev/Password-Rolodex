import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:password_manager_app/models/models.dart';
import 'package:password_manager_app/routes.dart';
import 'package:password_manager_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sQController = TextEditingController();
  final TextEditingController _sQAController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    children: const [
                      Text(
                        "Register",
                        style: kPrimaryTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Create a new protected user account!",
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
                                "First Name",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "First Name",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _firstnameController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Last Name",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Last Name",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _lastnameController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Username",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Username",
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
                            PasswordInput(
                              hintText: "Password",
                              onChangedAction: (s) {},
                              controller: _passwordController,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Security Question",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Security Question",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _sQController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Used when you need to reset you password.",
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
                                "Security Question Answer",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Security Question Answer",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _sQAController,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            MainButton(
                              buttonColor: kMainColor,
                              buttonText: "Register",
                              onPressed: () async {
                                String firstName = _firstnameController.text;
                                String lastName = _lastnameController.text;
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                String securityQuestion = _sQController.text;
                                String securityQuestionAnswer =
                                    _sQAController.text;

                                if (firstName.isEmpty ||
                                    lastName.isEmpty ||
                                    username.isEmpty ||
                                    password.isEmpty ||
                                    securityQuestion.isEmpty ||
                                    securityQuestionAnswer.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CustomAlertDialog(
                                      dialogTitle: 'Invalid Input!',
                                      dialogBody:
                                          'you have to fill all the fields!',
                                    ),
                                    barrierDismissible: false,
                                  );
                                } else {
                                  UserModel userModel = Provider.of<UserModel>(
                                      context,
                                      listen: false);
                                  User user = User(
                                    firstName: firstName,
                                    lastName: lastName,
                                    userName: username,
                                    password: password,
                                    securityQuestion: securityQuestion,
                                    securityQuestionAnswer:
                                        securityQuestionAnswer,
                                  );
                                  bool isSuccessful =
                                      await userModel.register(user);
                                  if (isSuccessful) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed(RouteGenerator.homeRoute);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const CustomAlertDialog(
                                        dialogTitle: 'Invalid Username!',
                                        dialogBody:
                                            'This username is already in use.',
                                      ),
                                      barrierDismissible: false,
                                    );
                                  }
                                }
                              },
                              buttonTextColor: Colors.white,
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
