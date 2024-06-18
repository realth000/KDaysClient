import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

/// 网络相关的异常
@freezed
sealed class NetworkException with _$NetworkException {
  const factory NetworkException({
    required int? code,
    required String? message,
  }) = _NetworkException;
}
