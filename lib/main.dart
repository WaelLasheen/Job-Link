import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:job_link/core/consts/strings/secrets.dart';
import 'package:job_link/core/router/app_router.dart';
import 'package:job_link/core/theme/dark_theme_definition.dart';
import 'package:job_link/core/theme/light_theme_definition.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  await Hive.initFlutter();

  Hive.registerAdapter(TaskStatusEnumAdapter());
  Hive.registerAdapter(TaskAdapter());
  runApp(const JobLink());
}

class JobLink extends StatelessWidget {
  const JobLink({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: const [lightThemeDefinition],
        ),
        darkTheme: ThemeData.dark().copyWith(
          extensions: const [darkThemeDefinition],
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
