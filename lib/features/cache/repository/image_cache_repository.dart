import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/shared/models/cache/image_cache_response.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

/// 用于生成uuid
const Uuid _uuid = Uuid();

/// 图片缓存存放路径
late final Directory _imageCacheDir;

String _makeImageCachePath(String content) =>
    '${_imageCacheDir.path} / ${_uuid.v5(Namespace.URL, content)}';

/// 初始化
Future<void> initImageCache() async {
  _imageCacheDir =
      Directory('${(await getApplicationSupportDirectory()).path}/images');
  if (!_imageCacheDir.existsSync()) {
    await _imageCacheDir.create(recursive: true);
  }
}

/// 图片缓存repo
final class ImageCacheRepository {
  /// Constructor.
  ImageCacheRepository(this._netClientProvider);

  final NetClientProvider _netClientProvider;

  /// 持有传输[ImageCacheResponse]的[Stream] [response]
  ///
  /// * 图片缓存成功
  /// * 图片缓存失败
  /// * 图片缓存的状态，作为ui层询问“某个图片是否有缓存”的回应
  ///
  /// 供ui层的bloc监听，
  final _controller = BehaviorSubject<ImageCacheResponse>();

  /// 图片缓存事件[Stream]， 每个item代表一个图片缓存事件，事件可能是：
  ///
  /// * 图片缓存成功
  /// * 图片缓存失败
  /// * 图片缓存的状态，作为ui层询问“某个图片是否有缓存”的回应
  Stream<ImageCacheResponse> get response => _controller.asBroadcastStream();

  /// 记录正在加载的图片，用于去重，防止一张图片同时有两个或以上的加载动作
  final _loadingImages = <String>{};

  /// 销毁
  void dispose() {
    _controller.close();
  }

  /// 更新[url]对应图片的缓存，把图片内容拉取下来，保存到文件里
  ///
  /// ## 参数
  ///
  /// * [url] 图片的网址
  Future<void> updateImageCache(String url) async {
    if (_loadingImages.contains(url)) {
      // 不要重复加载
      return;
    }

    _loadingImages.add(url);
    _controller.add(ImageCacheResponse.loading(imageId: url));
    final resp = await _netClientProvider.getClient().getImage(url);
    _loadingImages.remove(url);
    switch (resp) {
      case Left(value: final e):
        talker.error('ImageCacheRepo: failed to update image cache: $e');
        _controller.add(ImageCacheResponse.failure(imageId: url));
      case Right(value: final v):
        final data = v.data as List<int>;
        await File(_makeImageCachePath(url)).writeAsBytes(data);
        _controller.add(
          ImageCacheResponse.success(
            imageId: url,
            imageData: Uint8List.fromList(data),
          ),
        );
    }
  }
}
