import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/auth/data/models/user.dart';

class JobOwner extends MyAppUser {
  final String companyName;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  const JobOwner({
    super.id,
    super.userType = 'jobOwner',
    required this.companyName,
    required super.hourlyRate,
    required super.monthlyRate,
  });

  @override
  JobOwner copyWith({String? id}) {
    return JobOwner(
      id: id ?? this.id,
      userType: userType,
      companyName: companyName,
      hourlyRate: hourlyRate,
      monthlyRate: monthlyRate,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      _firebaseStrings.userType: _firebaseStrings.jobOwner,
      _firebaseStrings.jobOwnerName: companyName,
    };
  }

  factory JobOwner.fromMap(Map<String, dynamic> map) {
    return JobOwner(
      id: map[_firebaseStrings.id],
      userType: map[_firebaseStrings.userType],
      hourlyRate: map[_firebaseStrings.hourlyRate],
      monthlyRate: map[_firebaseStrings.monthlyRate],
      companyName: map[_firebaseStrings.jobOwnerName],
    );
  }
}
