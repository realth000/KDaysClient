part of 'init_bloc.dart';

/// 初始化状态
@freezed
sealed class InitState with _$InitState {
  const InitState._();

  /// 初始状态，什么都没做
  const factory InitState.initial() = Initial;

  /// 正在从存储中加载数据
  const factory InitState.loadingData() = LoadingData;

  /// 加载完成
  const factory InitState.success({
    /// 设置项的值
    required SettingsMap settingsMap,

    /// 当前登录的用户的认证凭据
    ///
    /// 可为空，没有用户登录时为空
    required UserCredential? userCredential,
  }) = Success;
}
