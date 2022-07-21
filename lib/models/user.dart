const String tableUsers = 'users';

class UserFields {
  static const List<String> values = [
    userName,
    password,
    firstName,
    lastName,
    securityQuestion,
    securityQuestionAnswer
  ];

  static const String userName = 'userName';
  static const String password = 'password';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String securityQuestion = 'securityQuestion';
  static const String securityQuestionAnswer = 'securityQuestionAnswer';
}

class User {
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String securityQuestion;
  final String securityQuestionAnswer;

  const User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.securityQuestion,
    required this.securityQuestionAnswer,
  });

  Map<String, Object?> toJson() => {
        UserFields.userName: userName,
        UserFields.password: password,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.securityQuestion: securityQuestion,
        UserFields.securityQuestionAnswer: securityQuestionAnswer
      };

  User copy({
    String? firstName,
    String? lastName,
    String? userName,
    String? password,
    String? securityQuestion,
    String? securityQuestionAnswer,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        securityQuestion: securityQuestion ?? this.securityQuestion,
        securityQuestionAnswer:
            securityQuestionAnswer ?? this.securityQuestionAnswer,
      );

  static User fromJson(Map<String, Object?> json) => User(
        userName: json[UserFields.userName] as String,
        password: json[UserFields.password] as String,
        firstName: json[UserFields.firstName] as String,
        lastName: json[UserFields.lastName] as String,
        securityQuestion: json[UserFields.securityQuestion] as String,
        securityQuestionAnswer:
            json[UserFields.securityQuestionAnswer] as String,
      );

  @override
  String toString() {
    return 'Username = $userName \npassword = $password \nquestion = $securityQuestion \nAnswer = $securityQuestionAnswer';
  }
}
