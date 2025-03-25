import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  int _selectedIndex = 2;

  String _username = "";
  String _maskedEmail = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null && mounted) {
        setState(() {
          _username = data['username'] ?? 'No username';
          _maskedEmail = _maskEmail(user.email ?? '');
        });
      }
    }
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].length < 2) return "**protected**";
    return parts[0].substring(0, 2) + "*******@" + parts[1];
  }

  void _deleteAccount() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account? This cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // 1. Delete from Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        // 2. Sign out first
        await FirebaseAuth.instance.signOut();

        // 3. Delete the user (will throw if not recently re-authenticated)
        await user.delete();

        // 4. Navigate to login screen
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 252, 174, 41)),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text("Account Settings", style: TextStyle(color: Color.fromARGB(255, 252, 174, 41))),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Sleepy fox", style: TextStyle(color: Color.fromARGB(255, 252, 174, 41))),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.lightBlueAccent],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image.asset(
                      'Assets/SleepyFoxLogo512.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      shadowColor: Colors.black.withOpacity(0.4),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade800,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Username:", style: TextStyle(fontSize: 16, color: Colors.white70)),
                                  const SizedBox(height: 4),
                                  Text(_username, style: const TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  Text("Email:", style: TextStyle(fontSize: 16, color: Colors.white70)),
                                  const SizedBox(height: 4),
                                  Text(_maskedEmail, style: const TextStyle(fontSize: 18, color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 35),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/ResetPassword');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text("Change Password"),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _deleteAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text("Delete Account"),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.nightlight_round, "Sleep", 1),
              const SizedBox(width: 48),
              _buildNavItem(Icons.settings, "Settings", 2),
              _buildNavItem(Icons.logout, "Sign Out", 3),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 233, 166, 90),
          onPressed: () {},
          shape: const CircleBorder(),
          child: Image.asset(
            "Assets/SleepyFoxLogo512.png",
            width: 40,
            height: 40,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.transparent,
        ),
        child: SizedBox(
          height: 56,
          width: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: isSelected ? 0 : 4,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: isSelected ? 28 : 24,
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.amber.shade700 : Colors.white,
                    size: isSelected ? 28 : 24,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.amber.shade700 : Colors.white,
                  ),
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
