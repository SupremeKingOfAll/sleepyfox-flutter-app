import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();

  void _handlePasswordReset() async {
    try {
      // Check if the email exists
      final signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(_emailController.text);
      if (signInMethods.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Email does not exist.'),
          ),
        );
        return;
      }

      // Sends Email
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent!'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 217, 130),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset(
              'Assets/SleepyFoxLogo512.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 35),
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePasswordReset,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                side: const BorderSide(color: Colors.black, width: 0.5),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 35),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/Login'),
              child: const Text(
                'Back to Login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
