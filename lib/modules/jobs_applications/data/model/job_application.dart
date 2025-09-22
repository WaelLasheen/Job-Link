import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';

class JobApplication {
  final String? applicationId;
  final String jobId;
  final String jobTitle;
  final String jobOwnerId;
  final String freelancerId;
  final String freelancerName;
  JobApplicationStatusEnum status;
  final DateTime appliedAt;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  JobApplication({
    this.applicationId,
    required this.jobId,
    required this.jobTitle,
    required this.jobOwnerId,
    required this.freelancerId,
    required this.freelancerName,
    this.status = JobApplicationStatusEnum.pending,
    required this.appliedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      _firebaseStrings.applicationId: applicationId,
      _firebaseStrings.jobId: jobId,
      _firebaseStrings.jobTitle: jobTitle,
      _firebaseStrings.jobOwnerId: jobOwnerId,
      _firebaseStrings.freelancerId: freelancerId,
      _firebaseStrings.freelancerName: freelancerName,
      _firebaseStrings.applicationStatus: status.name,
      _firebaseStrings.applicationAppliedAt: appliedAt.toIso8601String(),
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      applicationId: map[_firebaseStrings.applicationId],
      jobId: map[_firebaseStrings.jobId],
      jobTitle: map[_firebaseStrings.jobTitle],
      jobOwnerId: map[_firebaseStrings.jobOwnerId],
      freelancerId: map[_firebaseStrings.freelancerId],
      freelancerName: map[_firebaseStrings.freelancerName],

      status: JobApplicationStatusEnum.values.firstWhere(
        (e) => e.name == map[_firebaseStrings.applicationStatus],
        orElse: () => JobApplicationStatusEnum.pending,
      ),
      appliedAt:
          DateTime.tryParse(map[_firebaseStrings.applicationAppliedAt] ?? "") ??
          DateTime.now(),
    );
  }

  JobApplication copyWith({String? applicationId}) {
    return JobApplication(
      applicationId: applicationId ?? this.applicationId,
      jobId: jobId,
      jobTitle: jobTitle,
      jobOwnerId: jobOwnerId,
      freelancerId: freelancerId,
      freelancerName: freelancerName,
      status: status,
      appliedAt: appliedAt,
    );
  }
}
