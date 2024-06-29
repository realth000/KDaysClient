/// 论坛相关的API
final class ForumApi {
  ForumApi._();

  /// 登录
  static const String login = 'api/plugin/call';

  /// 当前用户信息 *GET*
  static const String myInfo = 'api/my/info';

  /// 当前用户资料 *GET*
  static const String myProfile = 'api/my/profile';

  /// 分区板块列表
  static const String forumList = 'api/forum/list';
}
