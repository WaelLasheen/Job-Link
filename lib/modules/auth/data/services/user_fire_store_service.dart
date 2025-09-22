import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/modules/auth/data/models/user.dart';

class UserFireStoreService {
  static final UserFireStoreService _instance = UserFireStoreService._();
  factory UserFireStoreService() => _instance;
  UserFireStoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStrings _firebaseStrings = FirebaseStrings();

  // ----------*** Add user to firebase cloud firestore ***----------
  Future<void> addUser(MyAppUser user) async {
    try {
      await _firestore
          .collection(_firebaseStrings.usersCollection)
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      throw 'Error in addUser: $e';
    }
  }

  // ----------*** Get user from firebase cloud firestore ***----------
  Future<MyAppUser?> getUserData(String userId) async {
    try {
      final doc = await _firestore
          .collection(_firebaseStrings.usersCollection)
          .doc(userId)
          .get();
      if (!doc.exists) {
        return null;
      }
      String type = doc.data()![_firebaseStrings.userType];
      if (type == _firebaseStrings.freelancer) {
        return Freelancer.fromMap(doc.data()!);
      }

      if (type == _firebaseStrings.jobOwner) {
        return JobOwner.fromMap(doc.data()!);
      }

      return null;
    } catch (e) {
      throw 'Error in addUser: $e';
    }
  }
}
