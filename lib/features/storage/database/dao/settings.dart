part of 'dao.dart';

/// [Settings]表 dao
@DriftAccessor(tables: [Settings])
final class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin, LoggerMixin {
  /// Constructor.
  SettingsDao(super.db);

  /// 获取所有配置项
  Future<List<SettingsEntity>> getAll() async {
    return select(settings).get();
  }

  /// 获取设置项
  ///
  /// [T] 可为:
  ///
  /// * [String]
  /// * int
  /// * bool
  Future<T?> getValue<T>(String key) async {
    final value = await (select(settings)..where((e) => e.name.equals(key)))
        .getSingleOrNull();
    if (value == null) {
      return null;
    }
    if (T == String) {
      return value.stringValue! as T;
    } else if (T == int) {
      return value.intValue! as T;
    } else if (T == bool) {
      return value.boolValue! as T;
    }
    return null;
  }

  /// 保存设置项
  Future<void> setValue<T>(String key, T value) async {
    final SettingsCompanion companion;
    if (T == String) {
      companion = SettingsCompanion(
        name: Value(key),
        stringValue: Value(value as String),
      );
    } else if (T == int) {
      companion = SettingsCompanion(
        name: Value(key),
        intValue: Value(value as int),
      );
    } else if (T == bool) {
      companion = SettingsCompanion(
        name: Value(key),
        boolValue: Value(value as bool),
      );
    } else {
      // 不支持的类型
      error('SettingsDao intend to save unsupported setting type: '
          'key=$key, value=$value, type=$T');
      return;
    }

    await into(settings).insert(companion, mode: InsertMode.insertOrReplace);
  }
}
