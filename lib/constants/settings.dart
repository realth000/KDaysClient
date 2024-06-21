import 'package:kdays_client/shared/models/settings/settings_item.dart';

/// 所有的配置项的名字
abstract class SettingsKeys {
  /// 当前用户
  static const String currentUser = 'CurrentUser';

  /// 主题模式
  static const String themeMode = 'ThemeMode';
}

/// 所有配置项的默认值
abstract class SettingsDefaultValues {
  /// 当前用户
  static const currentUser = SettingsCurrentUser(
    key: SettingsKeys.currentUser,
    value: null,
    defaultValue: null,
  );

  /// 主题模式
  static const themeMode = SettingsThemeMode(
    key: SettingsKeys.themeMode,
    value: 1,
    defaultValue: 1,
  );
}
