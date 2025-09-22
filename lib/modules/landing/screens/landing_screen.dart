import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:job_link/modules/landing/controller/landing_provider.dart';
import 'package:job_link/modules/landing/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool isConnected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (isConnected) {
                return ChangeNotifierProvider(
                  create: (context) => LandingProvider(),
                  child: const SplashScreen(isOnline: true),
                );
              }
              return const SplashScreen(isOnline: false);
            },
        child: const SizedBox(),
      ),
    );
  }
}
