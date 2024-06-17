import 'dart:async';

import 'package:dio/dio.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';

/// 用于认证的repository
///
/// 提供用户认证相关的能力
final class AuthRepository {
  /// 登录
  AuthRepository() : _dio = Dio();

  /// ignore: unused_field
  final Dio _dio;

  /// 登录用户中心
  ///
  /// ## 参数
  ///
  /// * [username] 用户名或邮箱
  /// * [password] 密码
  ///
  /// ## 异常
  ///
  /// 可能抛出[AuthException] 异常
  Future<String> loginUserCenter({
    required String username,
    required String password,
  }) async {
    throw UnimplementedError();
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
  Future<void> loginForum({required String accessToken}) async {
    //
  }

  /// 用户退出登录
  Future<void> logout() async {
    //
  }
}
