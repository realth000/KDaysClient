import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:kdays_client/constants/api/user_center.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client.dart';

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
        talker.debug('loginUserCenter get data: ${v.data}');
        return Right('${v.data}');
    }
  }

  /// 登录论坛
  ///
  /// ## 参数
  ///
  /// * [accessToken] 用户中心的认证凭据
  ///
  /// ## 异常
  ///
  /// 可能抛出[AuthException] 异常
  Future<Either<AuthException, String>> loginForum({
    required String accessToken,
  }) async {
    throw UnimplementedError();
  }

  /// 用户退出登录
  Future<void> logout() async {
    //
  }
}