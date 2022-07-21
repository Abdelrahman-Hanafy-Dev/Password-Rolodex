import 'dart:math';

class PasswordGenerator {
  static String generateRandomString() {
    var r = Random();
    return String.fromCharCodes(
        List.generate(10, (index) => r.nextInt(33) + 89));
  }
}
