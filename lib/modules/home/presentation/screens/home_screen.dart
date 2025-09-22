import 'package:flutter/material.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/home/presentation/widgets/custom_drawer.dart';
import 'package:job_link/modules/jobs/controller/jobs_cubit/jobs_cubit.dart';
import 'package:job_link/modules/jobs/presentation/screens/get_jobs_screen.dart';
import 'package:job_link/modules/jobs_applications/controller/job_application_cubit/job_application_cubit.dart';
import 'package:job_link/modules/jobs_applications/presentation/screens/get_jobs_applications_screen.dart';
import 'package:job_link/modules/task/controllers/task_cubit/task_cubit.dart';

class HomeScreen extends StatefulWidget {
  final MyAppUser user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isFreelancer;

  void initializationCubits(BuildContext context) {
    final JobsCubit jobCubit = JobsCubit.get(context);
    final JobApplicationCubit jobApplicationCubit = JobApplicationCubit.get(
      context,
    );
    if (isFreelancer) {
      jobCubit.getAllJobs();
      jobApplicationCubit.getJobApplicationsForFreelancer(widget.user.id!);
      TaskCubit.get(context).getFreelancerTasks(widget.user.id!);
    } else {
      jobCubit.getJobOwnerJobs(widget.user.id!);
      jobApplicationCubit.getJobApplicationsForJobOwner(widget.user.id!);
      TaskCubit.get(context).getJobOwnerTasks(widget.user.id!);
    }
  }

  @override
  void initState() {
    super.initState();
    isFreelancer = widget.user is Freelancer;
    _tabController = TabController(length: isFreelancer ? 2 : 3, vsync: this);
    initializationCubits(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFreelancer ? "Freelancer Dashboard" : "Job Owner Dashboard",
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: isFreelancer
              ? const [
                  Tab(text: "Available Jobs"),
                  Tab(text: "My Applications"),
                ]
              : const [
                  Tab(text: "My Job Posts"),
                  Tab(text: "Candidates"),
                  Tab(text: "Accepted"),
                ],
        ),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: TabBarView(
        controller: _tabController,
        children: isFreelancer
            ? [
                GetJobsScreen(user: widget.user),
                const GetJobsApplicationsScreen(),
              ]
            : [
                GetJobsScreen(user: widget.user),
                const GetJobsApplicationsScreen(),
                const GetJobsApplicationsScreen(isOnlyAccepted: true),
              ],
      ),
    );
  }
}
