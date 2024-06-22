import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/cache/repository/image_cache_repository.dart';

part 'image_cache_bloc.freezed.dart';
part 'image_cache_event.dart';
part 'image_cache_state.dart';

typedef _Emit = Emitter<ImageCacheState>;

/// 图片缓存bloc
///
/// 在需要图片的地方调用，每张图都带有一个bloc
///
/// 需要重新缓存图片时，由ui层发送事件[ImageCacheEvent]触发重新缓存。
/// 后续有结果时（缓存成功/失败），
class ImageCacheBloc extends Bloc<ImageCacheEvent, ImageCacheState> {
  /// Constructor.
  ImageCacheBloc(this._repo) : super(const ImageCacheState.initial()) {
    on<ImageCacheEvent>((event, emit) async {
      switch (event) {
        case LoadRequested():
          await _onLoadRequested(emit);
        case _Pending():
        // TODO: Handle this case.
        case _Success():
        // TODO: Handle this case.
        case _Failure():
        // TODO: Handle this case.
      }
    });
  }

  final ImageCacheRepository _repo;

  Future<void> _onLoadRequested(_Emit emit) async {
    //
  }
}
