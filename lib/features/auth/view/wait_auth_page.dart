import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kdays_client/constants/layout.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/routes/screen_paths.dart';
import 'package:kdays_client/utils/show_snack_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// 等待用户授权的页面
class WaitAuthPage extends StatefulWidget {
  /// Constructor.
  const WaitAuthPage({
    required this.username,
    required this.password,
    required this.authUrl,
    super.key,
  });

  /// 用户名
  final String username;

  /// 密码
  final String password;

  /// 用户可以给当前app授权的网页的网址
  ///
  /// 默认跳转到当前页面时会自带一个，后续如果网址更新了，在state里更新
  final String authUrl;

  @override
  State<WaitAuthPage> createState() => _WaitAuthPageState();
}

class _WaitAuthPageState extends State<WaitAuthPage> {
  /// 用户给app授权的网址
  late String _authUrl;

  @override
  void initState() {
    super.initState();
    _authUrl = widget.authUrl;
  }

  Widget _buildAuthCard(BuildContext context, AuthState state) {
    return Card.filled(
      child: Padding(
        padding: edgeInsetsL20T20R20B20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "(='X'=)",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ],
            ),
            sizedBoxH20W20,
            Text(
              '需要在用户中心授予DarkFlameMaster客户端权限，以继续使用',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            sizedBoxH20W20,
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: state.isProcessing
                        ? null
                        : () async => launchUrlString(
                              _authUrl,
                              mode: LaunchMode.externalApplication,
                            ),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('打开网址'),
                  ),
                ),
                sizedBoxH10W10,
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: state.isProcessing
                        ? null
                        : () => context.read<AuthBloc>().add(
                              AuthEvent.loginUserCenter(
                                input: widget.username,
                                password: widget.password,
                              ),
                            ),
                    icon: const Icon(Icons.arrow_right_alt),
                    label: const Text('授权好了'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        switch (state) {
          case Failed(:final e):
            if (e case AppNotAuthed(:final authUrl)) {
              _authUrl = authUrl;
              showSnackBar(context, '还没授权呢，再打开一次网址，给个授权吧求求了');
            } else {
              showSnackBar(context, e.toString());
            }
          case Authed():
            context.pushReplacementNamed(ScreenPaths.home);
          case AuthStateInitial():
          case ProcessingUserCenter():
          case ProcessingForum():
          case NotAuthed():
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('等待授权'),
                floating: true,
                snap: true,
              ),
              SliverList.list(
                children: [
                  sizedBoxH20W20,
                  _buildAuthCard(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
