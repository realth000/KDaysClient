import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';

/// 认证凭据，包含用于的url，固定的api及需要临时获取的认证凭据
@freezed
sealed class Credential with _$Credential {
  /// Constructor.
  const factory Credential({
    /// 用于的网址
    required String url,

    /// API key
    required String apiKey,

    /// API secret
    required String apiSecret,

    /// token，可为空
    required String? accessToken,
  }) = _Credential;

  const Credential._();

  /// 检查是否含有token
  bool get hasToken => accessToken != null;
}
