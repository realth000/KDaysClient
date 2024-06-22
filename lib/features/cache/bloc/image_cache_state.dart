part of 'image_cache_bloc.dart';

/// 图片缓存状态
///
/// 代表单个图片的缓存的状态，是否是加载中，是否已加载完成
@freezed
class ImageCacheState with _$ImageCacheState {
  /// 初始状态
  const factory ImageCacheState.initial() = Initial;

  /// 加载中
  const factory ImageCacheState.loading() = Loading;

  /// 加载完成
  const factory ImageCacheState.success({
    /// 图片数据
    required Uint8List? data,
  }) = Success;

  /// 加载失败
  const factory ImageCacheState.failure() = Failure;
}
