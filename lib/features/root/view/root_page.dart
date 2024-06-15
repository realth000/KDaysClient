import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/features/root/cubit/root_cubit.dart';
import 'package:kdays_client/features/root/widgets/navigation_bar.dart';
import 'package:kdays_client/features/root/widgets/navigation_rail.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// App顶层页面，用来包裹在选项卡里的页面
final class RootPage extends StatefulWidget {
  /// Constructor.
  const RootPage(this.child, {super.key});

  /// 被包裹的里面的[Widget]
  final Widget child;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      child = Scaffold(
        body: Row(
          children: [
            const RootNavigationRail(),
            Expanded(child: widget.child),
          ],
        ),
      );
    } else {
      child = Scaffold(
        body: widget.child,
        bottomNavigationBar: const RootNavigationBar(),
      );
    }
    return BlocProvider(
      create: (_) => RootCubit(RootTab.home),
      child: child,
    );
  }
}
