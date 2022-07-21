import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:password_manager_app/routes.dart';
import 'package:password_manager_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameLoginController =
      TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
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
                        "Login",
                        style: kPrimaryTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Access your safely stored credentials!",
                        style: kSecondaryTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
                                "Username",
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Username",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _usernameLoginController,
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
                              controller: _passwordLoginController,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            MainButton(
                              buttonColor: kMainColor,
                              buttonText: "Login",
                              onPressed: () async {
                                String username = _usernameLoginController.text;
                                String password = _passwordLoginController.text;

                                if (username.isEmpty || password.isEmpty) {
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
                                  bool isSuccessful =
                                      await userModel.login(username, password);
                                  if (isSuccessful) {
                                    await Provider.of<CredentialsModel>(context,
                                            listen: false)
                                        .getCredentials(username);
                                    Navigator.of(context)
                                        .pushNamed(RouteGenerator.homeRoute);
                                    print(
                                        'Username: ${Provider.of<UserModel>(context, listen: false).currentUser!.userName}');
                                    print(
                                        'creds: ${Provider.of<CredentialsModel>(context, listen: false).userCredentials}');
                                    _passwordLoginController.clear();
                                    _passwordLoginController.text = '';
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const CustomAlertDialog(
                                        dialogTitle: 'Invalid Input!',
                                        dialogBody:
                                            'Wrong username or password(or both!)',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have a user?",
                                  style: TextStyle(
                                    color: kSecondaryTextColor,
                                    fontSize: 17.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        RouteGenerator.registerRoute);
                                  },
                                  child: const Text(
                                    "Register User",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Forgot your Password?",
                                  style: TextStyle(
                                    color: kSecondaryTextColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String username =
                                        _usernameLoginController.text;
                                    if (username.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const CustomAlertDialog(
                                          dialogTitle: 'Invalid Input!',
                                          dialogBody:
                                              'You have to enter the username to be able to proceed.',
                                        ),
                                        barrierDismissible: false,
                                      );
                                    } else {
                                      bool userExists =
                                          await Provider.of<UserModel>(context,
                                                  listen: false)
                                              .forgotPassword(username);
                                      if (userExists) {
                                        Navigator.of(context).pushNamed(
                                            RouteGenerator.resetPasswordRoute);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const CustomAlertDialog(
                                            dialogTitle: 'Invalid Input!',
                                            dialogBody:
                                                'There is no user with this username.',
                                          ),
                                          barrierDismissible: false,
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
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
