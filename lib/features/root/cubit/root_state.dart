part of 'root_cubit.dart';

/// Root包含的选项卡
enum RootTab {
  /// 主页
  home,

  /// 我的
  my,

  /// 设置
  settings,
}

/// Root状态，只包含应用底部tab是哪个tab
@freezed
sealed class RootState with _$RootState {
  const factory RootState({
    /// 首页当前所在的选项卡
    required RootTab tab,
  }) = _Home;
}
