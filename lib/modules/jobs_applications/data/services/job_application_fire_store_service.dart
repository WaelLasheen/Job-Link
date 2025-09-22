import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/data/model/job_application.dart';

class JobApplicationFireStoreService {
  static final JobApplicationFireStoreService _instance =
      JobApplicationFireStoreService._();
  factory JobApplicationFireStoreService() => _instance;
  JobApplicationFireStoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  Future<JobApplication> applyAtJobApplication(
    JobApplication jobApplication,
  ) async {
    try {
      final docRef = _firestore
          .collection(_firebaseStrings.jobApplicationsCollection)
          .doc();
      jobApplication = jobApplication.copyWith(applicationId: docRef.id);
      await docRef.set(jobApplication.toMap());
      return jobApplication;
    } catch (e) {
      throw 'Error in applyAtJobApplication: $e';
    }
  }

  Future<List<JobApplication>> getJobApplicationsForFreelancer(
    String freelancerId,
  ) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.jobApplicationsCollection)
          .where(_firebaseStrings.freelancerId, isEqualTo: freelancerId)
          .get();
      return doc.docs.map((e) => JobApplication.fromMap(e.data())).toList();
    } catch (e) {
      throw 'Error in getAllJobApplicationsOfCurrentFreelancer: $e';
    }
  }

  Future<void> cancelJobApplication(String jobApplicationId) async {
    try {
      await _firestore
          .collection(_firebaseStrings.jobApplicationsCollection)
          .doc(jobApplicationId)
          .delete();
    } catch (e) {
      throw 'Error in cancelJobApplication: $e';
    }
  }

  Future<List<JobApplication>> getJobApplicationsOfJobOwnerJobs(
    String jobOwnerId,
  ) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.jobApplicationsCollection)
          .where(_firebaseStrings.jobOwnerId, isEqualTo: jobOwnerId)
          .get();
      return doc.docs.map((e) => JobApplication.fromMap(e.data())).toList();
    } catch (e) {
      throw 'Error in getJobApplicationsOfJobOwnerJobs: $e';
    }
  }

  Future<void> updateStatus(
    String jobApplicationId,
    JobApplicationStatusEnum status,
  ) async {
    try {
      await _firestore
          .collection(_firebaseStrings.jobApplicationsCollection)
          .doc(jobApplicationId)
          .update({_firebaseStrings.applicationStatus: status.name});
    } catch (e) {
      throw 'Error in addAcceptedFreelancer: $e';
    }
  }
}
