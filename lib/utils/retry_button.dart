import 'package:flutter/material.dart';
import 'package:kdays_client/constants/layout.dart';
import 'package:kdays_client/extensions/list.dart';

/// 建一个“重试”按钮
///
/// ## 参数
///
/// * [onPressed] 按下去的回调
Widget buildRetryButton(
  BuildContext context,
  VoidCallback onPressed, {
  String? message,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '(>_<)',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          message ?? '加载失败了',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        ConstrainedBox(
          constraints: dependentButtonConstraints,
          child: FilledButton(
            onPressed: onPressed,
            child: const Text('重试'),
          ),
        ),
      ].insertBetween(sizedBoxH10W10),
    ),
  );
}
