import 'package:flutter/material.dart';
import 'package:job_link/core/consts/assets_path/lottie_url.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/core/shared/validation/validation_services.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/modules/auth/presentation/widgets/app_password_field.dart';
import 'package:job_link/core/shared/widgets/app_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      body: Selector<UserProvider, bool>(
        selector: (_, provider) => provider.isLoading,
        builder: (_, isLoading, child) {
          return ModalProgressHUD(inAsyncCall: isLoading, child: child!);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    _header(theme),
                    const SizedBox(height: 12),
                    AppTextField(
                      hint: 'Email',
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validator: ValidationServices.validateEmail,
                    ),
                    AppPasswordField(
                      hint: 'Password',
                      controller: passwordController,
                      validator: ValidationServices.validatePassword,
                    ),
                    const SizedBox(height: 12),
                    _button(),
                    _alreadyHaveAccount(theme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(AppTheme theme) {
    return Column(
      children: [
        Lottie.asset(LottieUrl().login),
        Text('Login', style: theme.titleStyle.copyWith(fontSize: 42)),
        Text(
          'Please login to continue',
          style: theme.hintStyle.copyWith(fontSize: 20),
        ),
      ],
    );
  }

  Widget _button() {
    return AppButton(
      text: 'Login',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          final provider = context.read<UserProvider>();
          provider
              .login(
                email: emailController.text,
                password: passwordController.text,
              )
              .then((user) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(provider.message)));
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RouterStrings.home, arguments: user!);
                }
              })
              .catchError((e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(provider.message)));
                }
              });
        }
      },
    );
  }

  Widget _alreadyHaveAccount(AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("don't have an account? ", style: theme.bodyStyle),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RouterStrings.selectUserType);
            },
            child: Text(
              'register',
              style: theme.labelStyle.copyWith(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
