import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/features/auth/repository/auth_repository.dart';
import 'package:kdays_client/instance.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// 认证的bloc，认证相关的逻辑都在这里
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor.
  AuthBloc(this._repo) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case _LoginUserCenter(:final username, :final password):
          await _onLoginUserCenter(
            emit,
            username: username,
            password: password,
          );
        case _LoginForum(:final accessToken):
          await _onLoginForum(emit, accessToken: accessToken);
      }
    });
  }

  final AuthRepository _repo;

  Future<void> _onLoginUserCenter(
    _Emit emit, {
    required String username,
    required String password,
  }) async {
    emit(
      AuthState.processingUserCenter(
        username: username,
        password: password,
      ),
    );
    try {
      final accessToken = await _repo.loginUserCenter(
        username: username,
        password: password,
      );
      // 用户中心认证通过，接下来认证论坛
      add(AuthEvent.loginForum(accessToken: accessToken));
    } on AuthException catch (e, st) {
      talker.handle(e, st, 'AuthException occurred');
    } on Exception catch (e, st) {
      talker.handle(e, st, 'Unexpected exception type occurred');
    }
  }

  Future<void> _onLoginForum(
    _Emit emit, {
    required String accessToken,
  }) async {
    //
  }
}
