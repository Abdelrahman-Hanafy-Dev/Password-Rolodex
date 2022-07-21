import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:password_manager_app/models/models.dart';
import 'package:password_manager_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
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
                        "Reset Password",
                        style: kPrimaryTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Follow the steps to update your password.",
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
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                Provider.of<UserModel>(context)
                                        .currentUser!
                                        .securityQuestion +
                                    ' ?',
                                style: kThirdTextStyle,
                              ),
                            ),
                            StringInput(
                              hintText: "Answer the security question",
                              onChangedAction: (s) {},
                              icon: Icons.person_outline,
                              controller: _answerController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "New Password",
                                style: kThirdTextStyle,
                              ),
                            ),
                            PasswordInput(
                              hintText: "New password",
                              onChangedAction: (s) {},
                              controller: _passwordController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                "Confirm new password",
                                style: kThirdTextStyle,
                              ),
                            ),
                            PasswordInput(
                              hintText: "Confirm password",
                              onChangedAction: (s) {},
                              controller: _confirmPasswordController,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            MainButton(
                              buttonColor: kMainColor,
                              buttonText: "Update Password",
                              onPressed: () async {
                                String questionAnswer = _answerController.text;
                                String newPassword = _passwordController.text;
                                String confirmPassword =
                                    _confirmPasswordController.text;

                                if (questionAnswer.isEmpty ||
                                    newPassword.isEmpty ||
                                    confirmPassword.isEmpty) {
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
                                  User? currentUser = Provider.of<UserModel>(
                                          context,
                                          listen: false)
                                      .currentUser;
                                  if (questionAnswer ==
                                      currentUser?.securityQuestionAnswer) {
                                    if (_passwordController.text ==
                                        _confirmPasswordController.text) {
                                      bool isSuccessful =
                                          await Provider.of<UserModel>(context,
                                                  listen: false)
                                              .changePassword(
                                                  _passwordController.text);
                                      if (isSuccessful) {
                                        CustomSnackBars.showCustomSnackBar(
                                            context,
                                            'Password changed successfully!');
                                        Provider.of<UserModel>(context,
                                                listen: false)
                                            .resetUser();
                                        Navigator.of(context).pop();
                                      } else {
                                        CustomSnackBars.showCustomSnackBar(
                                            context, 'Something went wrong.');
                                        Provider.of<UserModel>(context,
                                                listen: false)
                                            .resetUser();
                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const CustomAlertDialog(
                                          dialogTitle: 'Invalid Input!',
                                          dialogBody:
                                              'Make sure you confirm your new password correctly',
                                        ),
                                        barrierDismissible: false,
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const CustomAlertDialog(
                                        dialogTitle: 'Invalid Input!',
                                        dialogBody:
                                            'Wrong answer to the security question.',
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
