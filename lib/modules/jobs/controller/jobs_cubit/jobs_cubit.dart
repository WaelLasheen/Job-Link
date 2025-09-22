import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs/data/services/job_fire_store_service.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  final JobFireStoreService jobFireStoreService;
  JobsCubit(this.jobFireStoreService) : super(JobsInitial());
  List<Job> jobs = [];

  void getAllJobs() {
    emit(JobsLoading());
    jobFireStoreService
        .getAllJobs()
        .then((allJobs) {
          jobs = allJobs;
          emit(JobsLoaded(allJobs));
        })
        .catchError((error) {
          emit(JobsError(error.toString()));
        });
  }

  void getJobOwnerJobs(String jobOwnerId) {
    emit(JobsLoading());
    jobFireStoreService
        .getJobOwnerJobs(jobOwnerId)
        .then((allJobs) {
          jobs = allJobs;
          emit(JobsLoaded(allJobs));
        })
        .catchError((error) {
          emit(JobsError(error.toString()));
        });
  }

  void addJob(Job job) {
    emit(JobsLoading());
    jobFireStoreService
        .addJob(job)
        .then((job) {
          jobs.add(job);
          emit(JobsLoaded(jobs));
        })
        .catchError((error) {
          emit(JobsError(error.toString()));
        });
  }

  static JobsCubit get(context) => BlocProvider.of(context);
}
