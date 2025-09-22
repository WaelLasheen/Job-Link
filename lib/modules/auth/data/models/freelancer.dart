import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/auth/data/models/user.dart';

class Freelancer extends MyAppUser {
  final String name;
  final String jobTitle;
  final String experience;
  final String? cvUrl;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  const Freelancer({
    super.id,
    super.userType = 'freelancer',
    required this.name,
    required this.jobTitle,
    required this.experience,
    required super.hourlyRate,
    required super.monthlyRate,
    this.cvUrl,
  });

  @override
  Freelancer copyWith({String? id, String? cvUrl}) {
    return Freelancer(
      id: id ?? this.id,
      userType: userType,
      name: name,
      jobTitle: jobTitle,
      experience: experience,
      cvUrl: cvUrl ?? this.cvUrl,
      hourlyRate: hourlyRate,
      monthlyRate: monthlyRate,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      _firebaseStrings.name: name,
      _firebaseStrings.userType: _firebaseStrings.freelancer,
      _firebaseStrings.jobTitle: jobTitle,
      _firebaseStrings.experience: experience,
      _firebaseStrings.cvUrl: cvUrl,
    };
  }

  factory Freelancer.fromMap(Map<String, dynamic> map) {
    return Freelancer(
      id: map[_firebaseStrings.id],
      userType: map[_firebaseStrings.userType],
      name: map[_firebaseStrings.name],
      experience: map[_firebaseStrings.experience],
      jobTitle: map[_firebaseStrings.jobTitle],
      hourlyRate: map[_firebaseStrings.hourlyRate],
      monthlyRate: map[_firebaseStrings.monthlyRate],
      cvUrl: map[_firebaseStrings.cvUrl],
    );
  }
}
