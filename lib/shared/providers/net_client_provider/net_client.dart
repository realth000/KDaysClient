import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/shared/models/app_credential.dart';
import 'package:kdays_client/shared/models/user_credential.dart';
import 'package:kdays_client/shared/providers/net_client_provider/exception.dart';

extension _DateTimeExt on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).round();
}

/// 网络请求头中需要包含的字段
final class _HeaderKeys {
  _HeaderKeys._();

  /// API签名
  static const sign = 'X-SIGN';

  /// API Key
  static const apiKey = 'X-API-KEY';

  /// 时间戳
  static const signTime = 'X-SIGN-TIME';

  /// 用户的access token
  static const token = 'X-TOKEN';
}

/// 网络请求的client，封装了一层dio，负责附加各类参数及处理问题
///
/// 为保证使用的凭据是最新的，每个网络请求都应单独构建一个最新的[NetClient]
final class NetClient {
  /// Constructor.
  const NetClient({
    required Dio dio,
    required UserCredential? userCredential,
    required AppCredential userCenterCredential,
    required AppCredential forumCredential,
  })  : _dio = dio,
        _userCenter = userCenterCredential,
        _forum = forumCredential,
        _userCredential = userCredential;

  final Dio _dio;

  /// 用于用户中心的凭据
  final AppCredential _userCenter;

  /// 用于论坛的凭据
  final AppCredential _forum;

  final UserCredential? _userCredential;

  /// 向用户中心发送post请求
  Future<Either<NetworkException, Response<dynamic>>> postUserCenter(
    String api,
    Map<String, dynamic> data,
  ) async {
    final timeStamp = DateTime.now().secondsSinceEpoch;
    try {
      final resp = await _dio.postUri<dynamic>(
        Uri.https(_userCenter.url, api),
        data: data,
        options: Options(
          headers: {
            _HeaderKeys.apiKey: _userCenter.apiKey,
            _HeaderKeys.sign: _signApi(
              secret: _userCenter.apiSecret,
              data: jsonEncode(data),
              timeStamp: timeStamp,
            ),
            _HeaderKeys.signTime: timeStamp,
            if (_userCredential != null)
              _HeaderKeys.token: _userCredential.userCenterToken,
          },
        ),
      );
      if (resp.statusCode != HttpStatus.ok) {
        return Left(NetworkException(code: resp.statusCode, message: null));
      }
      return Right(resp);
    } on DioException catch (e, st) {
      talker.handle(e, st);
      return Left(NetworkException(code: null, message: e.message));
    }
  }

  /// 论坛get请求
  Future<Either<NetworkException, Response<dynamic>>> getForum(
    String api,
  ) async {
    final timeStamp = DateTime.now().secondsSinceEpoch;
    try {
      final resp = await _dio.getUri<dynamic>(
        Uri.https(_forum.url, api),
        options: Options(
          headers: {
            _HeaderKeys.apiKey: _forum.apiKey,
            _HeaderKeys.sign: _signApi(
              secret: _forum.apiSecret,
              data: '',
              timeStamp: timeStamp,
            ),
            _HeaderKeys.signTime: timeStamp,
            if (_userCredential != null)
              _HeaderKeys.token: _userCredential.forumToken,
          },
        ),
      );
      if (resp.statusCode != HttpStatus.ok) {
        return Left(NetworkException(code: resp.statusCode, message: null));
      }
      return Right(resp);
    } on DioException catch (e, st) {
      talker.handle(e, st);
      return Left(NetworkException(code: null, message: e.message));
    }
  }

  /// 向论坛发送post请求
  Future<Either<NetworkException, Response<dynamic>>> postForum(
    String api,
    Map<String, dynamic> data,
  ) async {
    final timeStamp = DateTime.now().secondsSinceEpoch;
    try {
      final resp = await _dio.postUri<dynamic>(
        Uri.https(_forum.url, api),
        data: data,
        options: Options(
          headers: {
            _HeaderKeys.apiKey: _forum.apiKey,
            _HeaderKeys.sign: _signApi(
              secret: _forum.apiSecret,
              data: jsonEncode(data),
              timeStamp: timeStamp,
            ),
            _HeaderKeys.signTime: timeStamp,
            if (_userCredential != null)
              _HeaderKeys.token: _userCredential.forumToken,
          },
        ),
      );
      if (resp.statusCode != HttpStatus.ok) {
        return Left(NetworkException(code: resp.statusCode, message: null));
      }
      return Right(resp);
    } on DioException catch (e, st) {
      talker.handle(e, st);
      return Left(NetworkException(code: null, message: e.message));
    }
  }

  String _signApi({
    required String secret,
    required String data,
    required int timeStamp,
  }) =>
      sha1.convert(utf8.encode('$data$secret$timeStamp')).toString();
}
