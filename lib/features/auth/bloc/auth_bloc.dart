import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/features/auth/repository/auth_repository.dart';
import 'package:kdays_client/utils/logger.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef _Emit = Emitter<AuthState>;

/// 认证的bloc，认证相关的逻辑都在这里
class AuthBloc extends Bloc<AuthEvent, AuthState> with LoggerMixin {
  /// Constructor.
  AuthBloc(this._repo) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case _CheckLogin():
          await _onCheckLogin(emit);
        case _LoginUserCenter(:final input, :final password):
          await _onLoginUserCenter(
            emit,
            input: input,
            password: password,
          );
        case _LoginForum(:final input, :final accessToken):
          await _onLoginForum(
            emit,
            input: input,
            userCenterAccessToken: accessToken,
          );
      }
    });
  }

  final AuthRepository _repo;

  Future<void> _onLoginUserCenter(
    _Emit emit, {
    required String input,
    required String password,
  }) async {
    emit(
      AuthState.processingUserCenter(
        input: input,
        password: password,
      ),
    );
    final authResult = await _repo.loginUserCenter(
      input: input,
      password: password,
    );
    switch (authResult) {
      case Left(value: final e):
        emit(AuthState.failed(e: e));
      case Right(value: final accessToken):
        // 用户中心认证通过，接下来认证论坛
        add(AuthEvent.loginForum(input: input, accessToken: accessToken));
    }
  }

  Future<void> _onLoginForum(
    _Emit emit, {
    required String input,
    required String userCenterAccessToken,
  }) async {
    emit(
      AuthState.processingForum(
        input: input,
        userCenterAccessToken: userCenterAccessToken,
      ),
    );
    final authResult =
        await _repo.loginForum(accessToken: userCenterAccessToken);
    switch (authResult) {
      case Left(value: final e):
        emit(AuthState.failed(e: e));
      case Right(value: final forumAccessToken):
        emit(
          AuthState.authed(
            input: input,
            userCenterToken: userCenterAccessToken,
            forumToken: forumAccessToken.token,
          ),
        );
    }
  }

  Future<void> _onCheckLogin(_Emit emit) async {
    debug('check login');
    final userCredential = await _repo.validateCredential();
    switch (userCredential) {
      case Left(value: final e):
        debug('check login result: not authed: $e');
        emit(const AuthState.notAuthed());
      case Right(value: final v):
        debug('check login, result: authed');
        emit(
          AuthState.authed(
            input: v.input,
            userCenterToken: v.userCenterToken,
            forumToken: v.forumToken,
          ),
        );
    }
  }
}
