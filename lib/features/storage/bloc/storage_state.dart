part of 'storage_bloc.dart';

/// 存储的 state
///
/// 空的，实际上存储没有状态
@freezed
class StorageState with _$StorageState {
  /// 占位用
  const factory StorageState.initial() = _Initial;
}
