part of 'models.dart';

/// 板块中最新一条回复的model
///
/// 和通用的回复model成员不同
@freezed
sealed class LastPostModel with _$LastPostModel {
  const factory LastPostModel({
    /// 发布者名称
    required String author,

    /// 所在的帖子的名称
    required String subject,

    /// 所在帖子的id
    required String tid,

    /// 发布时间
    ///
    /// 格式：YYYY-MM-DD hh:mm:ss
    required String date,

    /// 方便看的发布时间
    ///
    /// 和`date`一样，只是格式为“xx天前”
    @JsonKey(name: 'friendlyDate') required String readableDate,
  }) = _LastPostModel;

  /// Deserialize
  factory LastPostModel.fromJson(Map<String, dynamic> json) =>
      _$LastPostModelFromJson(json);
}
