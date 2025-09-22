import 'package:flutter/material.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/auth/data/services/user_fire_store_service.dart';

class LandingProvider with ChangeNotifier {
  Future<MyAppUser?> checkAuth({required BuildContext context}) async {
    final user = FirebaseAuthService().authState;

    if (user != null) {
      try {
        return await UserFireStoreService().getUserData(user.uid);
      } catch (e) {
        rethrow;
      }
    }

    return null;
  }

  void handelHomeNavigate(MyAppUser? user, BuildContext context) {
    String targetScreen = user != null
        ? RouterStrings.home
        : RouterStrings.login;

    Navigator.of(context).pushReplacementNamed(targetScreen, arguments: user);
  }
}
