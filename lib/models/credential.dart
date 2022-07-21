const String tableCredentials = 'credentialss';

class CredentialsFields {
  static const List<String> values = [
    title,
    email,
    password,
    category,
    notes,
    userName
  ];

  static const String title = 'title';
  static const String email = 'email';
  static const String password = 'password';
  static const String category = 'category';
  static const String notes = 'notes';
  static const String userName = 'userName';
}

class Credential {
  final String title;
  final String email;
  final String password;
  final String category;
  final String notes;
  final String userName;

  const Credential({
    required this.title,
    required this.email,
    required this.password,
    required this.category,
    required this.notes,
    required this.userName,
  });

  Map<String, Object?> toJson() => {
        CredentialsFields.title: title.toUpperCase(),
        CredentialsFields.email: email,
        CredentialsFields.password: password,
        CredentialsFields.category: category,
        CredentialsFields.notes: notes,
        CredentialsFields.userName: userName,
      };

  static Credential fromJson(Map<String, Object?> json) => Credential(
        title: json[CredentialsFields.title] as String,
        email: json[CredentialsFields.email] as String,
        password: json[CredentialsFields.password] as String,
        category: json[CredentialsFields.category] as String,
        notes: json[CredentialsFields.notes] as String,
        userName: json[CredentialsFields.userName] as String,
      );

  @override
  String toString() {
    return '$title + $category';
  }
}
