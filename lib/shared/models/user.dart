import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// 用户模型
@freezed
final class UserModel with _$UserModel {
  /// Constructor.
  const factory UserModel({
    /// UID
    required int uid,

    /// 昵称
    @JsonKey(name: 'nick') required String nickname,

    /// 头像链接
    @JsonKey(name: 'avatar') required String avatarUrl,
  }) = _UserModel;

  /// Deserialize
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
