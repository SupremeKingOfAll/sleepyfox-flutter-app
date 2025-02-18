import 'package:flutter/material.dart';
import 'package:elaros_gp4/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  /// Handles user sign-up
  Future<bool> signUp(
      String email, String password, BuildContext context) async {
    String? errorMessage = await _authService.signUp(email, password);

    if (errorMessage == null) {
      return true; // Sign-up successful
    } else {
      _showErrorMessage(context, "Sign-up failed: $errorMessage");
      return false;
    }
  }



  /// Handles user login
  Future<bool> loginUser(String email, String password, BuildContext context) async {
    //Checks if email or password is empty BEFORE calling Firebase
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _showErrorMessage(context, "Email and password cannot be empty.");
      return false;
    }

    String? errorMessage = await _authService.login(email, password);

    if (errorMessage == null) {
      return true; // Login successful
    } else {
      final customMessage = _FormatErrorMessage(errorMessage.trim());
      _showErrorMessage(context, customMessage);
      return false;
    }
  }


  String _FormatErrorMessage(String errorCode) {
    errorCode = errorCode.trim().toLowerCase(); //Ensures proper matching

    switch (errorCode) {
      case "invalid-email":
        return "Please enter a valid email address.";
      case "invalid-credential": // This error code is returned for incorrect email or password
        return "Incorrect email or password. Please try again.";
      default:
        print(" DEBUG: Unhandled Error Code → $errorCode");
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
