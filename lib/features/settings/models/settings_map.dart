import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_map.freezed.dart';

/// 全部设置项
@freezed
sealed class SettingsMap {
  /// Constructor.
  const factory SettingsMap({
    required String? currentUser,
  }) = _SettingsMap;
}
