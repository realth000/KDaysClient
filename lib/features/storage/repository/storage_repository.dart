import 'package:drift/drift.dart';
import 'package:kdays_client/constants/settings.dart';
import 'package:kdays_client/features/storage/database/dao/dao.dart';
import 'package:kdays_client/features/storage/database/database.dart';
import 'package:kdays_client/shared/models/settings/settings_item.dart';
import 'package:kdays_client/shared/models/settings/settings_map.dart';
import 'package:kdays_client/shared/models/user_credential.dart';
import 'package:kdays_client/utils/logger.dart';

extension _UserEntityExt on UserEntity {
  UserCredential toCredential() => UserCredential(
        input: input,
        password: password,
        userCenterToken: userCenterToken,
        forumToken: forumToken,
      );
}

/// 存储 repository
final class StorageRepository with LoggerMixin {
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
      debug('saveUserCredential for user $input');
      final id = await UserDao(_db).insertUser(
        UserCompanion(
          input: Value(input),
          password: Value(password),
          userCenterToken: Value(userCenterToken),
          forumToken: Value(forumToken),
        ),
      );
      debug('saveUserCredential saved id=$id for user $input');
    });
  }

  /// 根据用户名或邮箱[input]获取用户认证凭据
  ///
  /// ## 参数
  ///
  /// * [input] 用户名或邮箱
  Future<UserCredential?> loadUserCredential(String input) async {
    return (await UserDao(_db).selectUserByInput(input))?.toCredential();
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
      debug('saveSettings: key=$key, value=$value, type=$T');
      await SettingsDao(_db).setValue<T>(key, value);
    });
  }

  /// 加载所有配置项
  Future<SettingsMap> loadAllSettings() async {
    final allSettings = await SettingsDao(_db).getAll();

    SettingsCurrentUser? currentUser;
    SettingsThemeMode? themeMode;

    for (final settings in allSettings) {
      switch (settings.name) {
        case SettingsKeys.currentUser:
          currentUser = SettingsDefaultValues.currentUser
              .applyFromValue(settings.stringValue);
        case SettingsKeys.themeMode:
          themeMode =
              SettingsDefaultValues.themeMode.applyFromValue(settings.intValue);
        default:
          warning('loadAllSettings: unrecognized settings '
              'key ${settings.name}');
      }
    }

    return SettingsMap(
      currentUser: currentUser ?? SettingsDefaultValues.currentUser,
      themeMode: themeMode ?? SettingsDefaultValues.themeMode,
    );
  }
}
