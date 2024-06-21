part of 'settings_bloc.dart';

/// 设置事件
///
/// 均为写入设置项，写入的均是设置项的当前值，不能修改默认值或者键名
@freezed
class SettingsEvent with _$SettingsEvent {
  /// 设置当前用户
  const factory SettingsEvent.setCurrentUser({required String input}) =
      _SetCurrentUser;

  /// 设置主题模式
  const factory SettingsEvent.setThemeMode({required int themeMode}) =
      _SetThemeMode;
}
