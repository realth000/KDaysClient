part of 'home_bloc.dart';

/// 主页的状态
@freezed
class HomeState with _$HomeState {
  /// 初始状态
  const factory HomeState.initial() = Initial;

  /// 加载信息中
  ///
  /// 可能在加载板块信息，也可能在加载用户信息
  const factory HomeState.loading() = Loading;

  /// 加载完成
  const factory HomeState.success({
    required List<ForumInfoModel> forumInfoList,
  }) = Success;

  /// 加载失败
  const factory HomeState.failure({
    required HomeException e,
  }) = Failure;
}
