import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_resp.freezed.dart';
part 'server_resp.g.dart';

/// 服务器响应码
abstract class ServerRespCode {
  /// 正常
  static const ok = 0;
}

/// 服务器响应
@freezed
sealed class ServerResp with _$ServerResp {
  /// Constructor.
  const factory ServerResp({
    /// 错误码
    required int code,

    /// 错误信息
    @JsonKey(name: 'msg') required String? message,

    /// 正确的相应内容
    required dynamic data,
  }) = _ServerResp;

  const ServerResp._();

  /// Deserialize
  factory ServerResp.fromJson(Map<String, dynamic> json) =>
      _$ServerRespFromJson(json);

  /// 是否正常
  bool get ok => code == ServerRespCode.ok;
}
