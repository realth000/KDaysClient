part of 'image_cache_bloc.dart';

/// 图片缓存事件
///
/// 由ui层触发，后续走图片缓存重新加载的逻辑
@freezed
sealed class ImageCacheEvent with _$ImageCacheEvent {
  /// 请求加载
  const factory ImageCacheEvent.loadRequested({
    /// 无论是否有缓存，直接从网络加载
    @Default(false) required bool force,
  }) = LoadRequested;

  /// 以下为图片缓存响应事件
  ///
  /// 代表图片缓存最新的状态，是ui层触发[LoadRequested]后的响应，也就是由bloc发送给ui
  ///
  /// 内部事件

  /// 加载中
  const factory ImageCacheEvent.pending() = _Pending;

  /// 成功加载
  ///
  /// 包含图片数据[imageData]
  const factory ImageCacheEvent.success({
    /// 图片数据
    required Uint8List imageData,
  }) = _Success;

  /// 加载失败
  const factory ImageCacheEvent.failure() = _Failure;
}
