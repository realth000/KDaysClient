import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/root/cubit/root_cubit.dart';
import 'package:kdays_client/routes/screen_paths.dart';

part 'models.freezed.dart';
part 'navigation_bar_item.dart';

/// 导航栏内所有的选项卡。
const barItems = [
  NavigationBarItem(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: '主页',
    screenPath: ScreenPaths.home,
    tab: RootTab.home,
  ),
  NavigationBarItem(
    icon: Icon(Icons.person_outline),
    selectedIcon: Icon(Icons.person),
    label: '我的',
    screenPath: ScreenPaths.my,
    tab: RootTab.my,
  ),
];
