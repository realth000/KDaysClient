import 'package:kdays_client/constants/api/forum.dart';
import 'package:kdays_client/constants/api/user_center.dart';

/// API的provider
final class ApiProvider {
  /// Constructor.
  ApiProvider({
    required String userCenterUrl,
    required String forumUrl,
  })  : _userCenterUrl = userCenterUrl,
        _forumUrl = forumUrl;

  /// 用户中心地址
  String _userCenterUrl;

  /// 论坛地址
  String _forumUrl;

  /// 设置用户中心的网址
  // ignore: avoid_setters_without_getters
  set userCenterUrl(String url) => _userCenterUrl = url;

  /// 设置论坛的网址
  // ignore: avoid_setters_without_getters
  set forumUrl(String url) => _forumUrl = url;

  /// 用户中心登录
  Uri userCenterLogin() => Uri.https(_userCenterUrl, UserCenterApi.login);

  /// 用户中心，获取用户信息
  ///
  /// 获取的是当前已登录用户的信息
  Uri userCenterUserInfo() => Uri.https(_userCenterUrl, UserCenterApi.userInfo);

  /// 登录论坛
  Uri forumLogin() => Uri.https(_forumUrl, ForumApi.login);
}
