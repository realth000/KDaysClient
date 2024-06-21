import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/shared/models/settings/settings_item.dart';

part 'settings_map.freezed.dart';

/// 所有配置项的定义
@freezed
sealed class SettingsMap with _$SettingsMap {
  /// Constructor.
  const factory SettingsMap({
    /// 当前用户
    required SettingsItem<String?> currentUser,

    /// 主题模式，深浅色
    required SettingsItem<int> themeMode,
  }) = _SetttingsMap;
}
