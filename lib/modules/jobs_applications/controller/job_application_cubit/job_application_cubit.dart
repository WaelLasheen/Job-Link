import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';
import 'package:job_link/modules/jobs_applications/data/services/job_application_fire_store_service.dart';
part 'job_application_state.dart';

class JobApplicationCubit extends Cubit<JobApplicationState> {
  final JobApplicationFireStoreService jobApplicationFireStoreService;
  JobApplicationCubit(this.jobApplicationFireStoreService)
    : super(JobApplicationInitial());
  List<JobApplication> jobApplications = [];

  JobApplication? jobApplication;


  void getJobApplicationsForFreelancer(String freelancerId) {
    emit(JobApplicationLoading());
    jobApplicationFireStoreService
        .getJobApplicationsForFreelancer(freelancerId)
        .then((jobApplicationsOfFreelancer) {
          jobApplications = jobApplicationsOfFreelancer;
          emit(JobApplicationSuccess(jobApplications));
        })
        .catchError((e) {
          emit(JobApplicationFailure(e.toString()));
        });
  }

  void appliedBefore({required String freelanceID, required String jobID}) {
    this.jobApplication = jobApplications
        .where(
          (jobApplication) =>
              jobApplication.freelancerId == freelanceID &&
              jobApplication.jobId == jobID,
        )
        .firstOrNull;
  }

  void applyAtJobApplication(JobApplication jobApplication) {
    emit(JobApplicationLoading());
    jobApplicationFireStoreService
        .applyAtJobApplication(jobApplication)
        .then((jobApplication) {
          jobApplications.add(jobApplication);
          this.jobApplication = jobApplication;
          emit(JobApplicationSuccess(jobApplications));
        })
        .catchError((e) {
          emit(JobApplicationFailure(e.toString()));
        });
  }

  void cancelJobApplication() {
    emit(JobApplicationLoading());
    jobApplicationFireStoreService
        .cancelJobApplication(jobApplication!.applicationId!)
        .then((_) {
          jobApplications.remove(jobApplication);
          jobApplication = null;
          emit(JobApplicationSuccess(jobApplications));
        })
        .catchError((e) {
          emit(JobApplicationFailure(e.toString()));
        });
  }

  void getJobApplicationsForJobOwner(String jobOwnerId) {
    emit(JobApplicationLoading());
    jobApplicationFireStoreService
        .getJobApplicationsOfJobOwnerJobs(jobOwnerId)
        .then((jobApplicationsOfJobOwner) {
          jobApplications = jobApplicationsOfJobOwner;
          emit(JobApplicationSuccess(jobApplications));
        })
        .catchError((e) {
          emit(JobApplicationFailure(e.toString()));
        });
  }

  void updateStatus(String jobApplicationId, JobApplicationStatusEnum status) {
    emit(JobApplicationLoading());
    jobApplicationFireStoreService
        .updateStatus(jobApplicationId, status)
        .then((_) {
          for (JobApplication jobApplication in jobApplications) {
            if (jobApplication.applicationId == jobApplicationId) {
              jobApplication.status = status;
            }
          }
          emit(JobApplicationSuccess(jobApplications));
        })
        .catchError((e) {
          emit(JobApplicationFailure(e.toString()));
        });
  }

  static JobApplicationCubit get(context) => BlocProvider.of(context);
}
