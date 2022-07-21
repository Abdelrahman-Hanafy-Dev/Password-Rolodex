import 'package:flutter/material.dart';

import 'routes/routes.dart';

class RouteGenerator {
  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String addPasswordRoute = '/add_password';
  static const String resetPasswordRoute = '/reset_password';
  static const String testRoute = '/test';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegistrationPage(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case addPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => AddPasswordPage(),
        );
      case resetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(),
        );
      case testRoute:
        return MaterialPageRoute(
          builder: (_) => const TestPage(),
        );
      default:
        throw ('Invalid route error!');
    }
  }
}
