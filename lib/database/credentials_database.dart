import 'package:password_manager_app/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CredentialsDatabase {
  static final CredentialsDatabase instance = CredentialsDatabase._init();
  static Database? _database;

  CredentialsDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('credentials.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    print('Started creating tables');

    const String primaryKeyType = 'VARCHAR(50) PRIMARY KEY';
    const String textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableUsers(
        ${UserFields.userName} $primaryKeyType,
        ${UserFields.password} $textType,
        ${UserFields.firstName} $textType,
        ${UserFields.lastName} $textType,
        ${UserFields.securityQuestion} $textType,
        ${UserFields.securityQuestionAnswer} $textType
      );
    ''');

    await db.execute('''
      CREATE TABLE $tableCredentials(
        ${CredentialsFields.title} VARCHAR(50),
        ${CredentialsFields.email} VARCHAR(320),
        ${CredentialsFields.password} $textType,
        ${CredentialsFields.category} $textType,
        ${CredentialsFields.notes} TEXT,
        ${CredentialsFields.userName} VARCHAR(50),
        FOREIGN KEY (${CredentialsFields.userName}) REFERENCES $tableUsers(${UserFields.userName}) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY(${CredentialsFields.title},${CredentialsFields.email})
      );
    ''');

    print('Finished creating tables');
  }

  Future<bool> createUser(User user) async {
    print('Started creating user');

    final db = await instance.database;
    final userCheck = await getUser(user.userName);
    if (userCheck != null) {
      print('Ended creating user, already exists!');

      return false;
    } else {
      await db.insert(tableUsers, user.toJson());
      print('ended creating user');

      return true;
    }
  }

  Future<User?> getUser(String userName) async {
    print('Started getting user');

    final db = await instance.database;
    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.userName} = ?',
      whereArgs: [userName],
    );

    if (maps.isNotEmpty) {
      print('finished getting user');

      return User.fromJson(maps.first);
    } else {
      print('finished getting user, not found');
      return null;
    }
  }

  Future<Credential?> getCredential(
      String title, String email, String username) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCredentials,
      columns: CredentialsFields.values,
      where:
          '${CredentialsFields.title} = ? AND ${CredentialsFields.email} = ? AND ${CredentialsFields.userName} = ?',
      whereArgs: [title, email, username],
    );

    if (maps.isNotEmpty) {
      return Credential.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<bool> createCredential(Credential credential) async {
    print('started creating a new credential');
    final credentialCheck = await getCredential(
        credential.title.toUpperCase(), credential.email, credential.userName);
    if (credentialCheck != null) {
      print('finished creating credential, it already exists!');
      return false;
    } else {
      final db = await instance.database;
      await db.insert(tableCredentials, credential.toJson());
      print('finished creating credential, Success');
      return true;
    }
  }

  Future<List<Credential>> getAllCredentials(String userName) async {
    print('Started getting all user credentials');
    final db = await instance.database;

    final maps = await db.query(
      tableCredentials,
      columns: CredentialsFields.values,
      where: '${CredentialsFields.userName} = ?',
      whereArgs: [userName],
      orderBy: '${CredentialsFields.title} ASC',
    );
    print('Finished getting user credentials');
    List<Credential> result = [];
    for (var map in maps) {
      result.add(Credential.fromJson(map));
    }
    return result;

//    return maps.map((item) => Credential.fromJson(item)) as List<Credential>;
  }

  Future<List<Credential>> getCredentialsByCategory(
      String username, String category) async {
    print('Started getting user credentials by category');

    final db = await instance.database;
    final maps = await db.query(
      tableCredentials,
      columns: CredentialsFields.values,
      where:
          '${CredentialsFields.userName} = ? AND ${CredentialsFields.category} = ?',
      whereArgs: [username, category],
      orderBy: '${CredentialsFields.title} ASC',
    );

    print('Finished getting user credentials by category');
    List<Credential> result = [];
    maps.forEach((element) {
      result.add(Credential.fromJson(element));
    });
    return result;
  }

  Future<List<Credential>> getCredentialsBySearch(
      String search, String username) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCredentials,
      columns: CredentialsFields.values,
      where: "${CredentialsFields.title} LIKE '%$search%'",
      orderBy: '${CredentialsFields.title} ASC',
    );
    print('Finished getting user credentials by category');
    List<Credential> result = [];
    maps.forEach((element) {
      result.add(Credential.fromJson(element));
    });
    return result;
  }

  Future<bool> changeUserPassword(User user) async {
    print('Started updating the password');
    final db = await instance.database;

    print(user);

    int rowsAffected = await db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.userName} = ?',
      whereArgs: [user.userName],
    );
    print('Rows affected = $rowsAffected}');
    return rowsAffected > 0;
  }

  Future<void> deleteCredential(
      String title, String email, String username) async {
    print('Started deleting a credential');
    final db = await instance.database;

    await db.delete(
      tableCredentials,
      where:
          '${CredentialsFields.title} = ? AND ${CredentialsFields.email} = ? AND ${CredentialsFields.userName} = ?',
      whereArgs: [title, email, username],
    );
    print('Finished deleting a credential');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
