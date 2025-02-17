import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'View/Login/login_view.dart';
import 'View/Register/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Set LoginPage as the home widget
      routes: {
        '/Dashboard': (context) => const DashboardView(),
        '/Register': (context) => const SignUpPage(),
        '/Login': (context) => const LoginPage(),
      },
    );
  }
}
