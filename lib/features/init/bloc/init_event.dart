part of 'init_bloc.dart';

/// 初始化相关的事件
@freezed
class InitEvent with _$InitEvent {
  /// 加载数据
  ///
  /// 此步骤为异步地从存储中加载数据
  ///
  /// * 用户认证凭据
  /// * 设置项
  const factory InitEvent.loadData() = _LoadData;
}
