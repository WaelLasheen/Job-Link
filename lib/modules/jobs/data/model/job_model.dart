import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/jobs/data/enum/payment_type_enum.dart';

class Job {
  final String? jobId;
  final String title;
  final String description;
  final PaymentTypeEnum paymentType;
  final int paymentRate;
  final List<String> requiredSkills;
  final String jobOwnerId;
  final String jobOwnerCompanyName;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  Job({
    this.jobId,
    required this.title,
    required this.description,
    required this.paymentRate,
    required this.paymentType,
    required this.requiredSkills,
    required this.jobOwnerId,
    required this.jobOwnerCompanyName,
  });

  Map<String, dynamic> toMap() {
    return {
      _firebaseStrings.jobId: jobId,
      _firebaseStrings.title: title,
      _firebaseStrings.description: description,
      _firebaseStrings.paymentRate: paymentRate,
      _firebaseStrings.paymentType: paymentType.name,
      _firebaseStrings.requiredSkills: requiredSkills,
      _firebaseStrings.jobOwnerId: jobOwnerId,
      _firebaseStrings.jobOwnerCompanyName: jobOwnerCompanyName,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobId: map[_firebaseStrings.jobId],
      title: map[_firebaseStrings.title],
      description: map[_firebaseStrings.description],
      paymentRate: map[_firebaseStrings.paymentRate],
      paymentType:
          map[_firebaseStrings.paymentType] == PaymentTypeEnum.perHour.name
          ? PaymentTypeEnum.perHour
          : PaymentTypeEnum.perMonth,
      requiredSkills: List<String>.from(
        map[_firebaseStrings.requiredSkills] ?? [],
      ),
      jobOwnerId: map[_firebaseStrings.jobOwnerId],
      jobOwnerCompanyName: map[_firebaseStrings.jobOwnerCompanyName],
    );
  }

  Job copyWith({String? jobId}) {
    return Job(
      jobId: jobId ?? this.jobId,
      title: title,
      description: description,
      paymentRate: paymentRate,
      paymentType: paymentType,
      requiredSkills: requiredSkills,
      jobOwnerId: jobOwnerId,
      jobOwnerCompanyName: jobOwnerCompanyName,
    );
  }
}
