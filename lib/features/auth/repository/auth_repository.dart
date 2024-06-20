import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:kdays_client/constants/api/forum.dart';
import 'package:kdays_client/constants/api/user_center.dart';
import 'package:kdays_client/constants/env.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/features/auth/models/models.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/shared/models/server_resp.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client.dart';

abstract class _AuthCode {
  static const accountNotCreated = -2;
  static const accountOrPasswordError = -4;
  static const appNotAuthed = -7;
}

abstract class _AuthKeys {
  static const pName = 'p_name';
  static const pNameValue = 'kduc';
  static const doo = 'do';
  static const dooValue = 'appAuthorize';
  static const apiKey = 'apikey';
  static const token = 'token';
}

extension _ServerRespToExceptionExt on ServerResp {
  /// 将[ServerResp]转化成[AuthException]
  ///
  /// 调用者需要仅在确实有错误的情况下调用该方法，否则可能会将没有报错的响应解读为报错。
  AuthException toException() => switch (code) {
        _AuthCode.accountNotCreated => const AuthException.accountNotCreated(),
        _AuthCode.accountOrPasswordError =>
          const AuthException.accountOrPasswordError(),
        _AuthCode.appNotAuthed => const AuthException.appNotAuthed(),
        final v => AuthException.unknown(code: v, message: message),
      };
}

/// 用于认证的repository
///
/// 提供用户认证相关的能力
final class AuthRepository {
  /// 登录
  AuthRepository(NetClient netClient) : _netClient = netClient;

  final NetClient _netClient;

  /// 登录用户中心
  ///
  /// ## 参数
  ///
  /// * [input] 用户名或邮箱
  /// * [password] 密码
  ///
  /// ## 返回值
  ///
  /// * [AuthException] 发生错误
  /// * [String] 认证凭据
  Future<Either<AuthException, String>> loginUserCenter({
    required String input,
    required String password,
  }) async {
    final authResult = await _netClient.postUserCenter(UserCenterApi.login, {
      'input': input,
      'password': password,
    });
    switch (authResult) {
      case Left(value: final e):
        return Left(
          AuthException.networkError(
            code: e.code,
            message: e.message,
          ),
        );
      case Right(value: final v):
        final resp = ServerResp.fromJson(v.data as Map<String, dynamic>);
        talker.debug('loginUserCenter got resp: $resp');
        if (!resp.ok) {
          return Left(resp.toException());
        }

        final userCenterToken =
            (resp.data as Map<String, dynamic>?)?['access_token'] as String?;
        if (userCenterToken == null) {
          talker.error('user center token not found in response');
          return const Left(AuthException.tokenNotFound());
        }
        _netClient.setUserCenterToken(userCenterToken);
        return Right(userCenterToken);
    }
  }

  /// 登录论坛
  ///
  /// ## 参数
  ///
  /// * [accessToken] 用户中心的认证凭据
  ///
  Future<Either<AuthException, ForumAuthPassedModel>> loginForum({
    required String accessToken,
  }) async {
    final authResult = await _netClient.postForum(
      ForumApi.login,
      {
        _AuthKeys.pName: _AuthKeys.pNameValue,
        _AuthKeys.doo: _AuthKeys.dooValue,
        // TODO: 不要写死API key
        _AuthKeys.apiKey: Env.userCenterApiKey,
        _AuthKeys.token: accessToken,
      },
    );

    switch (authResult) {
      case Left(value: final e):
        return Left(
          AuthException.networkError(
            code: e.code,
            message: e.message,
          ),
        );
      case Right(value: final v):
        final resp = ServerResp.fromJson(v.data as Map<String, dynamic>);
        talker.debug('loginForum got resp: $resp');
        if (!resp.ok) {
          return Left(resp.toException());
        }
        return Right(
          ForumAuthPassedModel.fromJson(resp.data as Map<String, dynamic>),
        );
    }
  }

  /// 用户退出登录
  Future<void> logout() async {
    //
  }
}
