/// 设置项的字符串名
final class SettingsKeys {
  SettingsKeys._();

  /// 当前已登录用户
  static const currentUser = 'CurrentUser';
}

/// 设置项的默认值
final class SettingsDefaultValue {
  SettingsDefaultValue._();

  /// 当前已登录用户
  ///
  /// 默认为空，未登录
  static const String? currentUser = null;
}
