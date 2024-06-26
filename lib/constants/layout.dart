import 'package:flutter/material.dart';

/// 独立使用的按钮的尺寸约束
///
/// 用在比较空旷的控件中，防止太窄或太宽
const dependentButtonConstraints = BoxConstraints(
  minWidth: 150,
  maxWidth: 250,
);

/// [SizedBox] 高为10宽为10
const sizedBoxH10W10 = SizedBox(width: 10, height: 10);

/// [SizedBox] 高为20宽为20
const sizedBoxH20W20 = SizedBox(width: 20, height: 20);

/// [SizedBox] 高为60宽为60
const sizedBoxH60W60 = SizedBox(width: 60, height: 60);

/// [EdgeInsets] 四周均为10
const edgeInsetsL10T10R10B10 = EdgeInsets.all(10);

/// [EdgeInsets] 四周均为20
const edgeInsetsL20T20R20B20 = EdgeInsets.all(20);
