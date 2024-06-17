import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';

/// 页面 “主页”
class HomePage extends StatelessWidget {
  /// Constructor.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return const Center(child: Text('主页'));
      },
    );
  }
}
