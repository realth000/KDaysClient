part of 'settings_bloc.dart';

/// 设置
@freezed
class SettingsState with _$SettingsState {
  /// 永远是加载完的状态
  const factory SettingsState.ok({
    required SettingsMap settingsMap,
  }) = _Ok;
}
