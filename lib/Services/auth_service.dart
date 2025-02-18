import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Handles user sign-up
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; //  Success
    } on FirebaseAuthException catch (e) { // 🔹 Catch specific Firebase errors
      return e.code; // Return only the Firebase error code
    } catch (e) {
      print("DEBUG: Unexpected Error → ${e.toString()}"); //  Debugging unknown errors
      return "unexpected-error"; // Generic fallback error
    }
  }

  /// Handles user login
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; //  Success
    } on FirebaseAuthException catch (e) { // 🔹 Catch specific Firebase errors
      print("DEBUG: FirebaseAuthException Code → ${e.code}"); //  Debugging
      return e.code; // Return only the Firebase error code
    } catch (e) {
      print("DEBUG: Unexpected Error → ${e.toString()}"); //  Debugging unknown errors
      return "unexpected-error"; // Generic fallback error
    }
  }
}
