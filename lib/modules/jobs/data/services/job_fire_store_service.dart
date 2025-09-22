import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';

class JobFireStoreService {
  static final JobFireStoreService _instance = JobFireStoreService._();
  factory JobFireStoreService() => _instance;
  JobFireStoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  Future<Job> addJob(Job job) async {
    try {
      final docRef = _firestore
          .collection(_firebaseStrings.jobsCollection)
          .doc();
      job = job.copyWith(jobId: docRef.id);
      await docRef.set(job.toMap());
      return job;
    } catch (e) {
      throw 'Error in addJob: $e';
    }
  }

  Future<List<Job>> getAllJobs() async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.jobsCollection)
          .get();
      return doc.docs.map((e) => Job.fromMap(e.data())).toList();
    } catch (e) {
      throw 'Error in getAllJobs: $e';
    }
  }

  Future<List<Job>> getJobOwnerJobs(String jobOwnerId) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.jobsCollection)
          .where(_firebaseStrings.jobOwnerId, isEqualTo: jobOwnerId)
          .get();
      return doc.docs.map((e) => Job.fromMap(e.data())).toList();
    } catch (e) {
      throw 'Error in getJobOwnerJobs: $e';
    }
  }

  Future<Job> getJobDetails(String jobId) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.jobsCollection)
          .doc(jobId)
          .get();
      return Job.fromMap(doc.data()!);
    } catch (e) {
      throw 'Error in getJobDetails: $e';
    }
  }
}
