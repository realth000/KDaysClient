import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_cache_response.freezed.dart';

/// 图片缓存的状态
///
/// 用于从`ImageCacheRepository`返回给ui层，告知图片缓存的状态
enum ImageCacheResponseStatus {
  /// 未缓存
  notCached,

  /// 缓存中
  loading,

  /// 已缓存
  cached,
}

/// `ImageCacheRepository`给ui层发送的事件，表示一个新的图片:
///
/// * 缓存成功
/// * 缓存失败
/// * 最新状态是什么[ImageCacheResponseStatus]，作为ui层询问的回复
@freezed
sealed class ImageCacheResponse with _$ImageCacheResponse {
  /// 图片缓存成功
  const factory ImageCacheResponse.success({
    /// 图片的id
    ///
    /// 通常使用url作为id
    required String imageId,

    /// 图片的数据
    required Uint8List imageData,
  }) = Success;

  /// 图片缓存中
  const factory ImageCacheResponse.loading({
    /// 图片的id
    ///
    /// 通常使用url作为id
    required String imageId,
  }) = Loading;

  const factory ImageCacheResponse.failure({
    /// 图片的id
    ///
    /// 通常使用url作为id
    required String imageId,
  }) = Failure;

  /// 包裹图片缓存状态，作为ui层询问图片缓存状态的回答
  const factory ImageCacheResponse.status({
    /// 图片的id
    ///
    /// 通常使用url作为id
    required String imageId,

    /// 缓存状态
    required ImageCacheResponseStatus status,

    /// 图片缓存数据
    ///
    /// 在ui层询问图片是否有缓存的时候，可能已经缓存过了，这时候回答里要包含图片数据
    required Uint8List? imageData,
  }) = Status;
}
