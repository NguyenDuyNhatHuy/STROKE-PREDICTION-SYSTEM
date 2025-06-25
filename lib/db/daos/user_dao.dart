import 'package:drift/drift.dart';
import '../database.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  Future<int> insertUser(UsersCompanion entry) => into(users).insert(entry);

  Future<User?> getUserByEmail(String email) {
    return (select(users)..where((tbl) => tbl.email.equals(email)))
        .getSingleOrNull();
  }

  Future<User?> login(String email, String password) async {
    final user = await getUserByEmail(email);
    if (user != null && user.password == password) return user;
    return null;
  }
}
