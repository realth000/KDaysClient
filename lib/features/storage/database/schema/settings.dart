part of 'schema.dart';

/// 应用设置表，不止用户可配置的设置，内部的一些配置存储也包含在此
///
/// 表中每一行是一个设置项
@DataClassName('SettingsEntity')
class Settings extends Table {
  /// 设置项的名字
  TextColumn get name => text()();

  /// int值
  IntColumn get intValue => integer().nullable()();

  /// string值
  TextColumn get stringValue => text().nullable()();

  /// bool值
  BoolColumn get boolValue => boolean().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {name};
}
