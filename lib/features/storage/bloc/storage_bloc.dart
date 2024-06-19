import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';

part 'storage_bloc.freezed.dart';
part 'storage_event.dart';
part 'storage_state.dart';

typedef _Emit = Emitter<StorageState>;

/// 存储的bloc
///
/// 存储相关的逻辑都在这里
class StorageBloc extends Bloc<StorageEvent, StorageState> {
  /// Constructor.
  StorageBloc(this._repo) : super(const StorageState.initial()) {
    on<StorageEvent>((event, emit) async {
      switch (event) {
        case _SaveUserCredential(
            :final input,
            :final password,
            :final userCenterToken,
            :final forumToken,
          ):
          await _onSaveUserCredential(
            emit,
            input: input,
            password: password,
            userCenterToken: userCenterToken,
            forumToken: forumToken,
          );
      }
    });
  }

  final StorageRepository _repo;

  Future<void> _onSaveUserCredential(
    _Emit emit, {
    required String input,
    required String password,
    required String userCenterToken,
    required String forumToken,
  }) async {
    await _repo.saveUserCredential(
      input: input,
      password: password,
      userCenterToken: userCenterToken,
      forumToken: forumToken,
    );
  }
}
