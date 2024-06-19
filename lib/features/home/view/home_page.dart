import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/constants/layout.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/exception/exception.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/utils/show_snack_bar.dart';

/// 页面 “主页”
class HomePage extends StatefulWidget {
  /// Constructor.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      listener: (context, state) {
        switch (state) {
          case AuthStateFailed(:final e):
            talker.handle(e);
            showSnackBar(context, '登录失败: ${e.message}');
          default:
            talker.debug('HomePage update AuthBloc state to $state');
        }
      },
      builder: (context, state) {
        return Padding(
          padding: edgeInsetsL10T10R10B10,
          child: _buildForm(context),
        );
      },
    );
  }
}
