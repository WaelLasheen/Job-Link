part of 'job_application_details_cubit.dart';

@immutable
sealed class JobApplicationDetailsState {}

final class JobApplicationDetailsInitial extends JobApplicationDetailsState {}

final class JobApplicationDetailsLoading extends JobApplicationDetailsState {}

final class JobApplicationDetailsSuccess extends JobApplicationDetailsState {
  final Job jobDetails;
  final Freelancer freelancerDetails;
  JobApplicationDetailsSuccess({
    required this.jobDetails,
    required this.freelancerDetails,
  });
}

final class JobApplicationDetailsFailure extends JobApplicationDetailsState {
  final String errMessage;
  JobApplicationDetailsFailure(this.errMessage);
}
