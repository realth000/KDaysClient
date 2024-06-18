import 'package:flutter/material.dart';

/// 在给定的[context]上显示[SnackBar]
///
/// 默认样式为[SnackBarBehavior.floating]
void showSnackBar(
  BuildContext context,
  String message, {
  bool floating = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(message),
    ),
  );
}
