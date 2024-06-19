part of 'dao.dart';

/// [User]表 dao.
@DriftAccessor(tables: [User])
final class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  /// Constructor.
  UserDao(super.db);

  /// 根据id获取用户
  Future<UserEntity?> selectUserById(int id) async {
    return (select(user)..where((e) => e.id.equals(id))).getSingleOrNull();
  }

  /// 根据用户名或邮箱[input]获取用户
  Future<UserEntity?> selectUserByInput(String input) async {
    return (select(user)..where((e) => e.input.equals(input)))
        .getSingleOrNull();
  }

  /// 插入用户数据
  ///
  /// 冲突时替换
  Future<int> insertUser(UserCompanion userCompanion) async {
    return into(user).insert(
      userCompanion,
      mode: InsertMode.insertOrReplace,
    );
  }

  /// 更新用户数据
  Future<bool> replaceUser(UserEntity userEntity) async {
    return update(user).replace(userEntity);
  }

  /// 删除用户
  Future<int> deleteUser(UserCompanion userCompanion) async {
    return (delete(user)..where((e) => e.id.equals(userCompanion.id.value)))
        .go();
  }
}
