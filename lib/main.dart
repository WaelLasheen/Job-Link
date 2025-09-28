import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:job_link/core/consts/strings/secrets.dart';
import 'package:job_link/core/controllers/theme_hydrated_cubit/theme_hydrated_cubit.dart';
import 'package:job_link/core/router/app_router.dart';
import 'package:job_link/core/theme/dark_theme_definition.dart';
import 'package:job_link/core/theme/light_theme_definition.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/modules/task/data/enum/task_state_enum.dart';
import 'package:job_link/modules/task/data/model/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  await Hive.initFlutter();
  Hive.registerAdapter(TaskStatusEnumAdapter());
  Hive.registerAdapter(TaskAdapter());

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(const JobLink());
}

class JobLink extends StatelessWidget {
  const JobLink({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: BlocProvider(
        create: (context) => ThemeHydratedCubit(),
        child: BlocBuilder<ThemeHydratedCubit, ThemeMode>(
          builder: (context, theme) {
            return MaterialApp(
              themeMode: theme,
              themeAnimationCurve: Curves.easeOut,
              themeAnimationDuration: const Duration(milliseconds: 300),
              theme: ThemeData.light().copyWith(
                extensions: const [lightThemeDefinition],
              ),
              darkTheme: ThemeData.dark().copyWith(
                extensions: const [darkThemeDefinition],
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
