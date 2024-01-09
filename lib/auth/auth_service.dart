import 'package:consultant_app/auth/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registerDoctor({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
    required String gender,
    required String specialist,
    required String bank,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      await FirestoreService().addUserDoctor(
        docPath: user?.uid as String,
        name: name,
        email: user?.email as String,
        phone: phone,
        address: address,
        gender: gender,
        specialist: specialist,
        bank: bank,
      );

      return 'Registration Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> registerPatient({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      await FirestoreService().addUserPatient(
        docPath: user?.uid as String,
        name: name,
        email: user?.email as String,
        phone: phone,
        address: address,
      );

      return 'Registration Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Login Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      return 'Logout Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
