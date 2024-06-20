import 'package:drift/drift.dart';
import 'package:kdays_client/features/settings/models/settings_keys.dart';
import 'package:kdays_client/features/settings/models/settings_map.dart';
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

  Future<void> loadUserCredential() async {
    return UserDao(_db).selectUserById(1);
  }

  /// Destructor.
  Future<void> dispose() async {
    await _db.close();
  }

  /// 获取类型为[T]的设置项
  Future<T?> loadSettings<T>(String key) async {
    return SettingsDao(_db).getValue<T>(key);
  }

  /// 保存类型为[T]的设置项
  Future<void> saveSettings<T>(String key, T value) async {
    await _db.transaction(() async {
      talker.debug('saveSettings: key=$key, value=$value, type=$T');
      await SettingsDao(_db).setValue<T>(key, value);
    });
  }

  /// 加载所有配置项
  Future<SettingsMap> loadAllSettings() async {
    final dao = SettingsDao(_db);
    return SettingsMap(
      currentUser: dao.getValue<String>(SettingsKeys.currentUser) as String? ??
          SettingsDefaultValue.currentUser,
    );
  }
}
