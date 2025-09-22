import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';

class FilterJobApplicationByStatusCubit extends Cubit<JobApplicationStatusEnum> {
  final List<JobApplication> jobApplications;
  FilterJobApplicationByStatusCubit(this.jobApplications)
    : super(JobApplicationStatusEnum.all) {
    filtered = jobApplications;
  }
  List<JobApplication> filtered = [];

  void filterJobApplication(JobApplicationStatusEnum status) {
    if (state == status) {
      return;
    }

    if (status == JobApplicationStatusEnum.all) {
      filtered = jobApplications;
    } else {
      filtered = jobApplications
          .where((jobApplication) => jobApplication.status == status)
          .toList();
    }

    emit(status);
  }

  static FilterJobApplicationByStatusCubit get(context) =>
      BlocProvider.of(context);
}
