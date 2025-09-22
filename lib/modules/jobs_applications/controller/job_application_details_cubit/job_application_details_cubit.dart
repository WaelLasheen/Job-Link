import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/services/user_fire_store_service.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs/data/services/job_fire_store_service.dart';

part 'job_application_details_state.dart';

class JobApplicationDetailsCubit extends Cubit<JobApplicationDetailsState> {
  final UserFireStoreService _userFireStoreService;
  final JobFireStoreService _jobFireStoreService;

  JobApplicationDetailsCubit({
    required UserFireStoreService userFireStoreService,
    required JobFireStoreService jobFireStoreService,
  }) : _jobFireStoreService = jobFireStoreService, _userFireStoreService = userFireStoreService, super(JobApplicationDetailsInitial());

  void getJobApplicationDetails({
    required String userId,
    required String jobId,
  }) {
    emit(JobApplicationDetailsLoading());
    late Job jobDetails;
    late Freelancer freelancerDetails;
    Future.wait([
          _jobFireStoreService.getJobDetails(jobId).then((details) {
            jobDetails = details;
          }),
          _userFireStoreService.getUserData(userId).then((details) {
            freelancerDetails = details as Freelancer;
          }),
        ])
        .then((_) {
          emit(
            JobApplicationDetailsSuccess(
              jobDetails: jobDetails,
              freelancerDetails: freelancerDetails,
            ),
          );
        })
        .catchError((e) {
          emit(JobApplicationDetailsFailure(e.toString()));
        });
  }

  static JobApplicationDetailsCubit get(context) => BlocProvider.of(context);
}
