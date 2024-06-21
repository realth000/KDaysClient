import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_credential.freezed.dart';

/// 认证凭据，包含用于的url，固定的api及需要临时获取的认证凭据
@freezed
sealed class AppCredential with _$AppCredential {
  /// Constructor.
  const factory AppCredential({
    /// 用于的网址
    required String url,

    /// API key
    required String apiKey,

    /// API secret
    required String apiSecret,
  }) = _AppCredential;

  const AppCredential._();
}
