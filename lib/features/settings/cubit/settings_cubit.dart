import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/settings/models/settings_map.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';
import 'package:kdays_client/instance.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

/// Setting cubit
class SettingsCubit extends Cubit<SettingsState> {
  /// Constructor.
  SettingsCubit(this._repo, SettingsMap settingsMap)
      : super(SettingsState.ok(settingsMap: settingsMap));

  final StorageRepository _repo;

  /// 获取设置的值
  ///
  /// ## 参数
  ///
  /// * [key] 设置项的名字
  /// * [T] 为设置项的类型
  Future<T?> getValue<T>(String key) async {
    if (T is String) {
      return (await _repo.loadSettings<String>(key)) as T;
    } else if (T is int) {
      return (await _repo.loadSettings<int>(key)) as T;
    } else if (T is bool) {
      return (await _repo.loadSettings<bool>(key)) as T;
    } else {
      talker.error('intend to load unsupported settings, key=$key, type=$T');
      return null;
    }
  }

  /// 保存设置的值
  ///
  /// ## 参数
  ///
  /// * [key] 设置项的名字
  /// * [value] 设置项的值
  /// * [T] 为设置项的类型
  Future<void> setValue<T>(String key, T value) async {
    if (T is String) {
      await _repo.saveSettings<String>(key, value as String);
    } else if (T is int) {
      await _repo.saveSettings<int>(key, value as int);
    } else if (T is bool) {
      await _repo.saveSettings<bool>(key, value as bool);
    } else {
      talker.error('intend to save unsupported settings, '
          'key=$key, vale=$value, type=$T');
      return;
    }
    // TODO: Update settings state.
  }
}
