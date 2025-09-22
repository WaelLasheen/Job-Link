import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/auth/data/services/user_fire_store_service.dart';
import 'package:job_link/modules/auth/presentation/screens/company_form_screen.dart';
import 'package:job_link/modules/auth/presentation/screens/freelancer_form_screen.dart';
import 'package:job_link/modules/auth/presentation/screens/login_screen.dart';
import 'package:job_link/modules/auth/presentation/screens/register_screen.dart';
import 'package:job_link/modules/auth/presentation/screens/select_user_type_screen.dart';
import 'package:job_link/modules/home/presentation/screens/home_screen.dart';
import 'package:job_link/modules/jobs/controller/jobs_cubit/jobs_cubit.dart';
import 'package:job_link/modules/jobs/controller/payment_type_cubit/payment_type_cubit.dart';
import 'package:job_link/modules/jobs/data/model/job_details_arguments.dart';
import 'package:job_link/modules/jobs/data/services/job_fire_store_service.dart';
import 'package:job_link/modules/jobs/presentation/screens/add_job_screen.dart';
import 'package:job_link/modules/jobs/presentation/screens/job_details_screen.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_details_cubit/job_application_details_cubit.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/data/services/job_application_fire_store_service.dart';
import 'package:job_link/modules/jobs_applications/presentation/screens/get_jobs_applications_screen.dart';
import 'package:job_link/modules/jobs_applications/presentation/screens/job_application_details_screen.dart';
import 'package:job_link/modules/landing/screens/landing_screen.dart';
import 'package:job_link/modules/task/controllers/date_cubit/date_cubit.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';
import 'package:job_link/modules/task/data/model/add_task_argus.dart';
import 'package:job_link/modules/task/data/service/task_firestore_service.dart';
import 'package:job_link/modules/task/data/service/task_hive_service.dart';
import 'package:job_link/modules/task/presentation/screens/add_task_screen.dart';
import 'package:job_link/modules/task/presentation/screens/get_tasks_screen.dart';
import 'package:job_link/modules/task/presentation/screens/task_details_screen.dart';

class AppRouter {
  late JobsCubit jobsCubit;
  late JobApplicationCubit jobApplicationCubit;
  late TaskCubit taskCubit;
  AppRouter() {
    jobsCubit = JobsCubit(JobFireStoreService());
    jobApplicationCubit = JobApplicationCubit(JobApplicationFireStoreService());
    taskCubit = TaskCubit(TaskFirestoreService(), TaskHiveService());
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterStrings.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouterStrings.selectUserType:
        return MaterialPageRoute(builder: (_) => const SelectUserTypeScreen());

      case RouterStrings.freelancerForm:
        return MaterialPageRoute(builder: (_) => const FreelancerFormScreen());

      case RouterStrings.companyForm:
        return MaterialPageRoute(builder: (_) => const CompanyFormScreen());

      case RouterStrings.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case RouterStrings.home:
        final MyAppUser user = settings.arguments as MyAppUser;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: jobsCubit),
              BlocProvider.value(value: jobApplicationCubit),
              BlocProvider.value(value: taskCubit),
            ],
            child: HomeScreen(user: user),
          ),
        );

      case RouterStrings.jobDetails:
        final JobDetailsArguments arguments =
            settings.arguments as JobDetailsArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              // for future if I need to add close job from job owner side
              // BlocProvider.value(value: jobsCubit),
              BlocProvider.value(value: jobApplicationCubit),
            ],
            child: JobDetailsScreen(arguments: arguments),
          ),
        );

      case RouterStrings.addJob:
        final JobOwner jobOwner = settings.arguments as JobOwner;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: jobsCubit),
              BlocProvider(create: (context) => PaymentTypeCubit()),
            ],
            child: AddJobScreen(jobOwner: jobOwner),
          ),
        );

      case RouterStrings.jobApplicationDetails:
        final JobApplication jobApplication =
            settings.arguments as JobApplication;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: jobApplicationCubit),
              BlocProvider(
                create: (context) => JobApplicationDetailsCubit(
                  userFireStoreService: UserFireStoreService(),
                  jobFireStoreService: JobFireStoreService(),
                ),
              ),
            ],
            child: JobApplicationDetailsScreen(application: jobApplication),
          ),
        );

      case RouterStrings.tasks:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: taskCubit,
            child: const GetTasksScreen(),
          ),
        );

      case RouterStrings.taskDetails:
        int taskIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: taskCubit,
            child: TaskDetailsScreen(taskIndex: taskIndex),
          ),
        );

      case RouterStrings.onlyAccepted:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: jobApplicationCubit,
            child: const GetJobsApplicationsScreen(isOnlyAccepted: true),
          ),
        );

      case RouterStrings.addTask:
        AddTaskArgus argus = settings.arguments as AddTaskArgus;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: taskCubit),
              BlocProvider(create: (context) => DateCubit()),
            ],
            child: AddTaskScreen(argus: argus),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: taskCubit,
            child: const LandingScreen(),
          ),
        );
    }
  }
}
