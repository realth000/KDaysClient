import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kdays_client/constants/layout.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/features/settings/bloc/settings_bloc.dart';
import 'package:kdays_client/features/storage/bloc/storage_bloc.dart';
import 'package:kdays_client/routes/route_params.dart';
import 'package:kdays_client/routes/screen_paths.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client_provider.dart';
import 'package:kdays_client/utils/logger.dart';
import 'package:kdays_client/utils/show_snack_bar.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  /// Constructor.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoggerMixin {
  /// 表格的key
  final formKey = GlobalKey<FormState>();

  /// 用户名或邮件的controller
  final inputController = TextEditingController();

  /// 密码的controller
  final passwordController = TextEditingController();

  /// 密码是否可见，临时控制
  bool showPassword = false;

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Center(
            child: Text(
              'KDays',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          sizedBoxH60W60,
          TextFormField(
            autofocus: true,
            controller: inputController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: '用户名或邮箱',
            ),
            validator: (v) => v!.trim().isNotEmpty ? null : '不能为空',
          ),
          sizedBoxH20W20,
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password_outlined),
              labelText: '密码',
              suffixIcon: Focus(
                canRequestFocus: false,
                descendantsAreFocusable: false,
                child: IconButton(
                  selectedIcon: const Icon(Icons.visibility_off_outlined),
                  icon: const Icon(Icons.visibility_outlined),
                  isSelected: showPassword,
                  onPressed: () => setState(() {
                    showPassword = !showPassword;
                  }),
                ),
              ),
            ),
            obscureText: !showPassword,
            validator: (v) => v!.trim().isNotEmpty ? null : '不能为空',
          ),
          sizedBoxH20W20,
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthEvent.loginUserCenter(
                            input: inputController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  child: Text(
                    '登录',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      // 如果当前页面不是顶层页面，也就是上面还盖着别的页面，啥也别干
      listenWhen: (prev, curr) => !context.canPop(),
      listener: (context, state) async {
        switch (state) {
          case Failed(:final e):
            handle(state);
            if (e case AppNotAuthed(:final authUrl)) {
              // 应用未获得用户授权，跳转到等待用户授权页面
              await context.pushNamed(
                ScreenPaths.loginWaitAuth,
                pathParameters: {
                  RouteParams.input: inputController.text,
                  RouteParams.password: passwordController.text,
                  RouteParams.authUrl: authUrl,
                },
              );
            } else {
              showSnackBar(context, e.message!);
            }
          case Authed(
              :final input,
              :final userCenterToken,
              :final forumToken,
            ):
            // 更新全局凭据
            context.read<NetClientProvider>().setUserCenterToken(forumToken);
            context.read<NetClientProvider>().setForumToken(forumToken);
            // 保存凭据
            context.read<StorageBloc>().add(
                  StorageEvent.saveUserCredential(
                    input: input,
                    password: passwordController.text,
                    userCenterToken: userCenterToken,
                    forumToken: forumToken,
                  ),
                );
            context
                .read<SettingsBloc>()
                .add(SettingsEvent.setCurrentUser(input: input));
            showSnackBar(context, '登录成功');
            context.pushReplacementNamed(ScreenPaths.home);
            SchedulerBinding.instance.addPersistentFrameCallback((_) {});
          default:
            debug('update AuthBloc state to $state');
        }
      },
      builder: (context, state) {
        final content = switch (state) {
          NotAuthed() || Failed() => _buildForm(context),
          _ => const Center(child: CircularProgressIndicator()),
        };
        return Scaffold(
          body: Padding(
            padding: edgeInsetsL10T10R10B10,
            child: content,
          ),
        );
      },
    );
  }
}
