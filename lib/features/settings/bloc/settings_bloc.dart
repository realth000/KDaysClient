import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/constants/settings.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';
import 'package:kdays_client/shared/models/settings/settings_map.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

typedef _Emit = Emitter<SettingsState>;

/// 设置bloc
final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// Constructor.
  SettingsBloc(this._repo, SettingsMap settingsMap)
      : super(SettingsState.ok(settingsMap: settingsMap)) {
    on<SettingsEvent>((event, emit) async {
      switch (event) {
        case _SetCurrentUser(:final input):
          await _onSetCurrentUser(emit, input);
      }
    });
  }

  final StorageRepository _repo;

  Future<void> _onSetCurrentUser(_Emit emit, String input) async {
    await _repo.saveSettings<String>(SettingsKeys.currentUser, input);
  }
}
