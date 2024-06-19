part of 'storage_bloc.dart';

/// 存储相关的事件
@freezed
class StorageEvent with _$StorageEvent {
  /// 保存用户认证凭据
  const factory StorageEvent.saveUserCredential({
    /// 用户名或邮箱
    required String input,

    /// 密码
    required String password,

    /// 用户中心token
    required String userCenterToken,

    /// 论坛token
    required String forumToken,
  }) = _SaveUserCredential;
}
