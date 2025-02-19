import 'package:flutter/material.dart';
import 'package:elaros_gp4/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  bool IfValidEmail(String email) {
    final emailChecker = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailChecker.hasMatch(email);
  }


  /// Handles user sign-up
  Future<bool> signUp(String email, String password, BuildContext context) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _showErrorMessage(context, "Email or password cannot be empty.");
      return false;
    }

    String? errorMessage = await _authService.signUp(email, password);

    if (errorMessage == null) {
      return true; // Sign-up successful
    } else {
      print("DEBUG: Firebase Sign-up Error Received → '$errorMessage'"); // ✅ Print error
      final signUpCustomMessage = _SignUpFormatErrorMessage(errorMessage.trim());
      _showErrorMessage(context, signUpCustomMessage);
      return false;
    }
  }


  String _SignUpFormatErrorMessage(String errorCode) {
    print("DEBUG: Received Firebase Error Code → '$errorCode'"); // ✅ Print error for debugging

    if (errorCode.startsWith("auth/")) {
      errorCode = errorCode.replaceFirst("auth/", ""); // ✅ Remove "auth/" prefix
    }

    switch (errorCode) {
      case "invalid-email":
        return "Please enter a valid email address.";
      case "email-already-exists": // ✅ Check correct Firebase error case
        return "This email is already registered. Try logging in.";
      default:
        print("DEBUG: Unhandled Sign-up Error Code → $errorCode"); // ✅ Debugging unknown errors
        return "An unexpected error occurred. Please try again.";
    }
  }



  /// Handles user login
  Future<bool> loginUser(String email, String password, BuildContext context) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _showErrorMessage(context, "Looks like either your email address or password were incorrect. Wanna try again?");
      return false;
    }

    if (!IfValidEmail(email)) {
      _showErrorMessage(context, "Looks like either your email address or password were incorrect. Wanna try again?");
      return false;
    }

    String? errorMessage = await _authService.login(email, password);

    if (errorMessage == null) {
      return true; // Login successful
    } else {
      //  Uncommented: Now it properly handles login errors
      final loginCustomMessage = _LoginFormatErrorMessage(errorMessage.trim());
      _showErrorMessage(context, loginCustomMessage);
      return false;
    }
  }

  String _LoginFormatErrorMessage(String errorCode) {
    errorCode = errorCode.trim().toLowerCase();

    switch (errorCode) {
      case "user-not-found":
        return "Looks like either your email address or password were incorrect. Wanna try again?";
      case "wrong-password":
        return "Looks like either your email address or password were incorrect. Wanna try again?";
      default:
        print("DEBUG: Unhandled Login Error Code → $errorCode");
        return "An unexpected error occurred. Please try again.";
    }
  }

  /// Shows an error message using Snackbar
  void _showErrorMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
