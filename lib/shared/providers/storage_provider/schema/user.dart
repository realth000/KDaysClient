part of 'schema.dart';

/// 用户表
///
/// 内部字段不为空，完整登录后再存储数据
@DataClassName('UserEntity')
class User extends Table {
  /// Id.
  IntColumn get id => integer().autoIncrement()();

  /// 用户名或密码
  TextColumn get input => text().unique()();

  /// 密码
  TextColumn get password => text()();

  /// 用户中心token
  TextColumn get userCenterToken => text()();

  /// 论坛token
  TextColumn get forumToken => text().nullable()();
}
