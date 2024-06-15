part of 'models.dart';

/// 导航栏中的item model，每一个[NavigationBarItem]代表一个导航栏中的选项卡
@freezed
sealed class NavigationBarItem with _$NavigationBarItem {
  /// Constructor.
  const factory NavigationBarItem({
    /// 图标
    required Icon icon,

    /// 选中时的图标
    required Icon selectedIcon,

    /// 显示的名字
    required String label,

    /// 对应的路由
    required String screenPath,

    /// 对应的[RootTab]
    required RootTab tab,
  }) = _NavigationBarItem;
}
