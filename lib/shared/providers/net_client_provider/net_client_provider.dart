import 'package:dio/dio.dart';
import 'package:kdays_client/shared/models/app_credential.dart';
import 'package:kdays_client/shared/models/user_credential.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client.dart';

/// HTTP client的provider
///
/// 使用这个可变的provider生成用于网络请求的http client，使得一些更改能够即时生效。
///
/// 作为[NetClient]的provider，需要作为全局唯一的获取[NetClient]的入口
final class NetClientProvider {
  /// Constructor.
  NetClientProvider({
    required AppCredential userCenterCredential,
    required AppCredential forumCredential,
    required UserCredential? userCredential,
  })  : _userCenter = userCenterCredential,
        _forum = forumCredential,
        _userCredential = userCredential;

  /// 用于用户中心的凭据
  AppCredential _userCenter;

  /// 用于论坛的凭据
  AppCredential _forum;

  /// 用户的认证凭据
  ///
  /// 只有用户登录成功后才不为空
  UserCredential? _userCredential;

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
  void setUserCenterToken(String token) =>
      _userCredential = _userCredential?.copyWith(userCenterToken: token);

  /// 设置论坛的token
  void setForumToken(String token) =>
      _userCredential = _userCredential?.copyWith(forumToken: token);

  /// 获取当前持有的用户认证凭据
  UserCredential? get userCredential => _userCredential;

  /// 生成一个最新的http client
  ///
  /// ## 参数
  ///
  /// * [userCredential] 用户的认证凭据，为空时采用Provider目前持有的凭据
  NetClient getClient({UserCredential? userCredential}) => NetClient(
        dio: Dio(),
        // 使用用户的认证凭据代表用户操作
        userCredential: userCredential ?? _userCredential,
        userCenterCredential: _userCenter,
        forumCredential: _forum,
      );
}
