import 'package:meet8/data/models/user_model.dart';
import 'package:meet8/domain/entities/user_entity.dart';
import 'package:meet8/domain/helper/database_helper.dart';
import 'package:meet8/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final DatabaseHelper dbHelper;
  UserRepositoryImpl(this.dbHelper);

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query("users");
    return maps.map((UserMap) => UserModel.fromMap(UserMap)).toList();
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      NoTelepon: user.NoTelepon,
      alamat: user.alamat
    );
    await db.insert('users', userModel.toMap());
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      NoTelepon: user.NoTelepon,
      alamat: user.alamat
    );
    await db.update(
      'users',
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(String id) async {
    final db = await dbHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
