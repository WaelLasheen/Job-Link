import 'package:job_link/core/consts/strings/firebase_strings.dart';

abstract class MyAppUser {
  final String? id;
  final String userType;
  final int hourlyRate;
  final int monthlyRate;

  const MyAppUser({
    this.id,
    required this.userType,
    required this.hourlyRate,
    required this.monthlyRate,
  });

  MyAppUser copyWith({String? id});

  Map<String, dynamic> toMap() {
    FirebaseStrings firebaseStrings = FirebaseStrings();
    return {
      firebaseStrings.id: id,
      firebaseStrings.userType: userType,
      firebaseStrings.hourlyRate: hourlyRate,
      firebaseStrings.monthlyRate: monthlyRate,
    };
  }
}
