part of 'settings_cubit.dart';

/// 设置项的状态
@freezed
class SettingsState with _$SettingsState {
  /// 状态值
  const factory SettingsState.ok({
    required SettingsMap settingsMap,
  }) = CurrentSettings;
}
