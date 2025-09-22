part of 'job_application_cubit.dart';

@immutable
sealed class JobApplicationState {}

final class JobApplicationInitial extends JobApplicationState {}

final class JobApplicationLoading extends JobApplicationState {}

final class JobApplicationSuccess extends JobApplicationState {
  final List<JobApplication> jobApplications;
  JobApplicationSuccess(this.jobApplications);
}

final class JobApplicationFailure extends JobApplicationState {
  final String errMessage;
  JobApplicationFailure(this.errMessage);
}
