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
  Future<bool> loginUser(
      String email, String password, BuildContext context) async {
    String? errorMessage = await _authService.login(email, password);

    if (errorMessage == null) {
      return true; // Login successful
    } else {
      _showErrorMessage(context, "Login failed: $errorMessage");
      return false;
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
