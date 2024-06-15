import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kdays_client/features/root/cubit/root_cubit.dart';
import 'package:kdays_client/features/root/models/models.dart';

/// 应用顶级的导航栏，底部导航栏，用于窄屏设备
class RootNavigationBar extends StatelessWidget {
  /// Constructor.
  const RootNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: barItems
          .map(
            (e) => NavigationDestination(
              icon: e.icon,
              selectedIcon: e.selectedIcon,
              label: e.label,
            ),
          )
          .toList(),
      selectedIndex: context.watch<RootCubit>().state.tab.index,
      onDestinationSelected: (index) {
        context.read<RootCubit>().setTab(barItems[index].tab);
        context.goNamed(barItems[index].screenPath);
      },
    );
  }
}
