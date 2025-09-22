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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Selector<UserProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (_, isLoading, child) =>
          ModalProgressHUD(inAsyncCall: isLoading, child: child!),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Lottie.asset(LottieUrl().register),
                    Text(
                      'Register',
                      style: theme.titleStyle.copyWith(fontSize: 42),
                    ),
                    Text(
                      'Please register to continue',
                      style: theme.hintStyle.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      hint: 'Email',
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validator: ValidationServices.validateEmail,
                    ),
                    const SizedBox(height: 4),
                    AppPasswordField(
                      hint: 'Password',
                      controller: passwordController,
                      validator: ValidationServices.validatePassword,
                    ),
                    const SizedBox(height: 4),
                    AppPasswordField(
                      hint: 'Confirm password',
                      controller: confirmPasswordController,
                      validator: (String? value) =>
                          ValidationServices.validateConfirmPassword(
                            value,
                            passwordController.text,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _button(),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return AppButton(
      text: 'Register',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          final provider = context.read<UserProvider>();
          provider
              .register(
                email: emailController.text,
                password: passwordController.text,
              )
              .then((user) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(provider.message)));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouterStrings.home,
                    (_) => false,
                    arguments: user!,
                  );
                }
              })
              .catchError((_) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(provider.message)));
                }
              });

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(provider.message)));
        }
      },
    );
  }
}
