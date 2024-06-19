import 'package:drift/drift.dart';
import 'package:kdays_client/features/storage/database/dao/dao.dart';
import 'package:kdays_client/features/storage/database/database.dart';
import 'package:kdays_client/instance.dart';

/// 存储 repository
final class StorageRepository {
  /// Constructor.
  const StorageRepository(this._db);

  final AppDatabase _db;

  /// 保存用户认证凭据
  Future<void> saveUserCredential({
    required String input,
    required String password,
    required String userCenterToken,
    required String forumToken,
  }) async {
    return _db.transaction(() async {
      talker.debug('saveUserCredential for user $input');
      final id = await UserDao(_db).insertUser(
        UserCompanion(
          input: Value(input),
          password: Value(password),
          userCenterToken: Value(userCenterToken),
          forumToken: Value(forumToken),
        ),
      );
      talker.debug('saveUserCredential saved id=$id for user $input');
    });
  }

  /// Destructor.
  Future<void> dispose() async {
    await _db.close();
  }
}
