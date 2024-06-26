part of 'schema.dart';

/// 图片缓存表
@DataClassName('ImageCacheEntity')
class ImageCache extends Table {
  /// Id.
  IntColumn get id => integer().autoIncrement()();

  /// 图片来源网址
  TextColumn get url => text().unique()();

  /// 缓存文件名
  TextColumn get fileName => text()();

  /// 上次缓存的时间戳
  ///
  /// 单位：毫秒
  IntColumn get lastCachedTime => integer()();

  /// 上次使用的时间戳
  ///
  /// 单位：毫秒
  IntColumn get lastUsedTime => integer()();
}
