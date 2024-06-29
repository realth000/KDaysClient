import 'package:flutter/foundation.dart';
import 'package:kdays_client/instance.dart';

/// 日志mixin
mixin LoggerMixin {
  /// 近在Debug下打印
  void onlyDebug(
    dynamic message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    if (!kDebugMode) {
      return;
    }
    debug(message, exception, stackTrace);
  }

  /// Debug级
  void debug(
    dynamic message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    talker.debug('$runtimeType: $message', exception, stackTrace);
  }

  /// Info级
  void info(
    dynamic message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    talker.info('$runtimeType: $message', exception, stackTrace);
  }

  /// Warning级
  void warning(
    dynamic message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    talker.warning('$runtimeType: $message', exception, stackTrace);
  }

  /// Error级
  void error(
    dynamic message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    talker.error('$runtimeType: $message', exception, stackTrace);
  }

  /// Exception
  void handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) {
    talker
      ..error('$runtimeType: handle error:')
      ..handle(exception, stackTrace, msg);
  }
}
