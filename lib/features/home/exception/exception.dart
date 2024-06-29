import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

/// 主页使用到的异常
@freezed
sealed class HomeException with _$HomeException {
  const HomeException._();

  /// 服务器返回的数据格式无效
  const factory HomeException.invalidReply() = _InvalidReply;

  /// 网络错误
  const factory HomeException.networkError({
    required int? code,
    required String? message,
  }) = _NetworkError;

  const factory HomeException.unknown({
    required int? code,
    required String? message,
  }) = _Unknown;
}
