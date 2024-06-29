import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/home/bloc/home_bloc.dart';
import 'package:kdays_client/features/home/repository/home_repository.dart';
import 'package:kdays_client/utils/retry_button.dart';
import 'package:kdays_client/utils/show_snack_bar.dart';

/// 主页
class HomePage extends StatefulWidget {
  /// Constructor.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HomeRepository(RepositoryProvider.of(context)),
        ),
        BlocProvider(
          create: (context) => HomeBloc(RepositoryProvider.of(context))
            ..add(const HomeEvent.loadForumInfo()),
        ),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state case Failure(e: final e)) {
            showSnackBar(context, '加载失败 $e');
          }
        },
        builder: (context, state) {
          final body = switch (state) {
            Success(:final forumInfoList) => Column(
                children: forumInfoList.map((e) => Text(e.toString())).toList(),
              ),
            Failed() => buildRetryButton(
                context,
                () => context
                    .read<HomeBloc>()
                    .add(const HomeEvent.loadForumInfo()),
              ),
            _ => const CircularProgressIndicator(),
          };

          return Scaffold(
            body: body,
          );
        },
      ),
    );
  }
}
