import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';
import 'package:kdays_client/shared/models/settings/settings_map.dart';
import 'package:kdays_client/shared/models/user_credential.dart';
import 'package:kdays_client/utils/logger.dart';

part 'init_bloc.freezed.dart';
part 'init_event.dart';
part 'init_state.dart';

typedef _Emit = Emitter<InitState>;

/// 负责启动时初始化逻辑
///
/// 包括初始数据的加载，以及一些一次性的事件处理
///
/// 理论上该bloc只会在应用启动时触发，后续运行过程中不会触发
final class InitBloc extends Bloc<InitEvent, InitState> with LoggerMixin {
  /// Constructor.
  InitBloc(this._storageRepo) : super(const InitState.initial()) {
    on<InitEvent>((event, emit) async {
      switch (event) {
        case _LoadData():
          await _onLoadData(emit);
      }
    });
  }

  final StorageRepository _storageRepo;

  Future<void> _onLoadData(_Emit emit) async {
    emit(const InitState.loadingData());

    /// 加载设置
    final settingsMap = await _storageRepo.loadAllSettings();

    /// 当前用户的认证凭据
    UserCredential? userCredential;

    final input = settingsMap.currentUser.value;
    debug('onLoadData load user credential for user $input');
    if (kDebugMode) {
      debug('loaded userCredential:');
    }
    if (input != null) {
      userCredential = await _storageRepo.loadUserCredential(input);
    }
    emit(
      InitState.success(
        settingsMap: settingsMap,
        userCredential: userCredential,
      ),
    );
  }
}
