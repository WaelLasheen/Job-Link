import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_link/core/consts/strings/firebase_strings.dart';
import 'package:job_link/modules/auth/data/enum/user_types_enum.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/auth/data/services/user_fire_store_service.dart';
import 'package:job_link/modules/auth/data/services/pick_file_service.dart';
import 'package:job_link/modules/auth/data/services/supabase_cloud_service.dart';

class UserProvider with ChangeNotifier {
  // ----------*** User type => Freelancer or Job owner ***----------
  UserTypeEnum _selectedType = UserTypeEnum.none;

  UserTypeEnum get selectedType => _selectedType;

  void setUserType(UserTypeEnum type) {
    _selectedType = type;
    notifyListeners();
  }

  // ----------*** Pick Freelancer CV ***----------
  File? _freelancerCV;

  Future<void> pickCV() async {
    _freelancerCV = await PickFileService().pickFile();
    notifyListeners();
  }

  File? get freelancerCV => _freelancerCV;
  void clearCV() {
    _freelancerCV = null;
  }

  // ----------*** Add User data ***----------
  MyAppUser? _user;

  void setUser(MyAppUser user) {
    _user = user;
  }

  MyAppUser? get user => _user;
  void clearUser() {
    _user = null;
  }

  // ----------*** Auth Service in general ***----------
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _message = '';
  String get message => _message;

  void _startAuth() {
    _isLoading = true;
    notifyListeners();
  }

  void _endAuth(String message) {
    _isLoading = false;
    _message = message;
    notifyListeners();
  }

  // ----------*** Auth Service Register ***----------
  Future<MyAppUser?> register({
    required String email,
    required String password,
  }) async {
    try {
      _startAuth();

      User? user = await FirebaseAuthService().registerWithEmail(
        email,
        password,
      );

      if (_selectedType == UserTypeEnum.freelancer) {
        // upload CV to supabase
        String? cvUrl = await SupabaseCloudService().uploadCV(_freelancerCV!);

        // modified user freelancer by copyWith
        _user = (_user as Freelancer).copyWith(id: user!.uid, cvUrl: cvUrl);
      }
      if (_selectedType == UserTypeEnum.jobOwner) {
        // modified user jobOwner by copyWith
        _user = (_user as JobOwner).copyWith(id: user!.uid);
      }

      // upload data to firebase database
      await UserFireStoreService().addUser(_user!);
    } catch (e) {
      _endAuth("Can't register at current time, please try latter");
      rethrow;
    }

    _endAuth("Register successfully");
    return _user;
  }

  // ----------*** Auth Service Login ***----------
  Future<MyAppUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      _startAuth();

      User? user = await FirebaseAuthService().loginWithEmail(email, password);

      MyAppUser? userFromCloud = await UserFireStoreService().getUserData(
        user!.uid,
      );

      setUser(userFromCloud!);
      _stringToEnum();
    } catch (e) {
      _endAuth("Can't login at current time, please try latter");
      notifyListeners();
      rethrow;
    }

    _endAuth("Login successfully");
    notifyListeners();
    return _user;
  }

  void _stringToEnum() {
    if (user == null) {
      _selectedType = UserTypeEnum.none;
    } else if (user!.userType == FirebaseStrings().freelancer) {
      _selectedType = UserTypeEnum.freelancer;
    } else if (user!.userType == FirebaseStrings().jobOwner) {
      _selectedType = UserTypeEnum.jobOwner;
    }
  }
}
