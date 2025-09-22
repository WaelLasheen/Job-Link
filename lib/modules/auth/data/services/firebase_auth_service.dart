import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._();
  factory FirebaseAuthService() => _instance;
  FirebaseAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Something went wrong with Firebase Authentication";
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Something went wrong with Firebase Authentication";
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw "Error in signOut: $e";
    }
  }

  // user state
  User? get authState => _auth.currentUser;
}
