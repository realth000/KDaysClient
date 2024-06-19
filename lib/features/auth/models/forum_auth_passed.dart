part of 'models.dart';

/// 论坛认证通过的model
@freezed
sealed class ForumAuthPassedModel with _$ForumAuthPassedModel {
  /// Constructor.
  const factory ForumAuthPassedModel({
    /// 论坛的token
    @JsonKey(name: 'access_token') required String token,

    /// token过期的时间戳
    @JsonKey(name: 'token_expired') required int expireTimestamp,
  }) = _ForumAuthPassedModel;

  /// Deserialize
  factory ForumAuthPassedModel.fromJson(Map<String, dynamic> json) =>
      _$ForumAuthPassedModelFromJson(json);
}
