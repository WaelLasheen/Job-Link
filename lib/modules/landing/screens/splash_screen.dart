import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_link/core/consts/assets_path/image_url.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/landing/controller/landing_provider.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final bool isOnline;
  const SplashScreen({super.key, required this.isOnline});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.isOnline) {
      final landingProvider = context.read<LandingProvider>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final user = await landingProvider.checkAuth(context: context);
        if (mounted) {
          landingProvider.handelHomeNavigate(user, context);
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TaskCubit.get(context).getTasksOffline();
        Navigator.of(context).pushReplacementNamed(RouterStrings.tasks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(ImageUrl().jobLinkLogo),
        ),
      ),
    );
  }
}
