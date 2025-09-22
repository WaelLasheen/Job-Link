import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobDetailsArguments {
  final Job job;
  final Freelancer? freelancer;
  JobDetailsArguments({required this.job, this.freelancer});
}
