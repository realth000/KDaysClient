import 'package:dio/dio.dart';
import 'package:kdays_client/shared/models/credential.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client.dart';

/// HTTP client的provider
///
/// 使用这个可变的provider生成用于网络请求的http client，使得一些更改能够即时生效。
final class NetClientProvider {
  /// Constructor.
  NetClientProvider({
    required Credential userCenterCredential,
    required Credential forumCredential,
  })  : _userCenter = userCenterCredential,
        _forum = forumCredential;

  /// 用于用户中心的凭据
  Credential _userCenter;

  /// 用于论坛的凭据
  Credential _forum;

  /// 设置用户中心的url
  void setUserCenterUrl(String url) =>
      _userCenter = _userCenter.copyWith(url: url);

  /// 设置论坛的url
  void setForumUrl(String url) => _forum = _forum.copyWith(url: url);

  /// 设置用户中心的API key
  void setUserCenterApiKey(String apiKey) =>
      _userCenter = _userCenter.copyWith(apiKey: apiKey);

  /// 设置论坛的API key
  void setForumApiKey(String apiKey) =>
      _forum = _forum.copyWith(apiKey: apiKey);

  /// 设置用户中心的API secret
  void setUserCenterApiSecret(String apiSecret) =>
      _userCenter = _userCenter.copyWith(apiSecret: apiSecret);

  /// 设置论坛的API secret
  void setForumApiSecret(String apiSecret) =>
      _forum = _forum.copyWith(apiSecret: apiSecret);

  /// 设置用户中心的token
  void setUserCenterToken(String accessToken) =>
      _userCenter = _userCenter.copyWith(accessToken: accessToken);

  /// 设置论坛的token
  void setForumToken(String accessToken) =>
      _forum = _forum.copyWith(accessToken: accessToken);

  /// 生成一个最新的http client
  NetClient getClient() => NetClient(
        dio: Dio(),
        userCenterCredential: _userCenter,
        forumCredential: _forum,
      );
}
