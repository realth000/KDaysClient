part of 'models.dart';

/// 论坛板块model
///
/// 比文档中标注的对应model多几个字段
@freezed
sealed class ForumInfoModel with _$ForumInfoModel {
  const factory ForumInfoModel({
    /// 板块头图的链接
    ///
    /// 可能为空
    required String? icon,

    /// 板块id
    required int fid,

    /// 板块名称
    required String name,

    /// 版主列表
    @JsonKey(name: 'manager') required List<String> managerList,

    /// 板块描述
    ///
    /// 可能为空字符串
    required String about,

    /// 板块内最新一条回复
    ///
    /// 可能不存在
    required LastPostModel? lastPost,

    /// 子板块
    ///
    /// 可能为空
    @JsonKey(name: 'forums') required List<ForumInfoModel>? subreddit,
  }) = _ForumInfoModel;

  /// Deserialize
  factory ForumInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ForumInfoModelFromJson(json);
}
