part of 'dao.dart';

/// [ImageCache]表dao
@DriftAccessor(tables: [ImageCache])
final class ImageCacheDao extends DatabaseAccessor<AppDatabase>
    with _$ImageCacheDaoMixin {
  /// Constructor.
  ImageCacheDao(super.db);

  /// 根据id获取图片缓存
  Future<ImageCacheEntity?> selectImageCacheById(int id) async {
    return (select(imageCache)..where((e) => e.id.equals(id)))
        .getSingleOrNull();
  }

  /// 根据图片网址获取图片缓存
  Future<ImageCacheEntity?> selectImageCacheByUrl(String url) async {
    return (select(imageCache)..where((e) => e.url.equals(url)))
        .getSingleOrNull();
  }

  /// 插入图片缓存数据
  ///
  /// 冲突时替换
  Future<int> insertImageCache(ImageCacheCompanion imageCacheCompanion) async {
    return into(imageCache).insert(
      imageCacheCompanion,
      mode: InsertMode.insertOrReplace,
    );
  }

  /// 根据图片[url]删除缓存
  Future<int> deleteImageCacheByUrl(String url) async {
    return (delete(imageCache)..where((e) => e.url.equals(url))).go();
  }

  /// 清空图片缓存
  Future<int> deleteAll() async {
    return delete(imageCache).go();
  }
}
