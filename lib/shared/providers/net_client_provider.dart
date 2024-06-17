import 'package:dio/dio.dart';

/// HTTP client的provider
final class NetClientProvider {
  /// 返回一个用于论坛和用户中心的http client
  Dio forumClient() => Dio();

  /// 返回一个非论坛和用户中心的http client
  Dio normalClient() => Dio();
}
