part of 'home_bloc.dart';

/// 主页的事件
@freezed
class HomeEvent with _$HomeEvent {
  /// 加载论坛板块数据
  const factory HomeEvent.loadForumInfo() = _LoadForumInfo;
}
