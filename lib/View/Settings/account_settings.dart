import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  int _selectedIndex = 2; // Default to Settings page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here (e.g., Navigator.pushNamed)
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Color.fromARGB(255, 202, 126, 33),
          ),
          backgroundColor: const Color.fromARGB(255, 234, 235, 235),
          title: const Text("Account Settings"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Sleepy fox"),
              ),
            ),
          ],
        ),

        //
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10), // Reduce side padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sleepy Fox Icon
                const SizedBox(height: 30),
                Image.asset(
                  'Assets/SleepyFoxLogo512.png',
                  width: 100, // Adjust size if needed
                  height: 100,
                ),

                const SizedBox(height: 20), // More spacing

                // Empty Full-width Expanded Settings Box
                Container(
                  width: double.infinity, // Full width
                  height: 600, // Increased height
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25), // More padding inside
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  // 🟡 Leave Container empty inside
                ),
              ],
            ),
          ),
        ),



        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.nightlight_round, "Sleep", 1),
              const SizedBox(width: 48), // Space for floating button
              _buildNavItem(Icons.settings, "Settings", 2), // Highlighted by default
              _buildNavItem(Icons.logout, "Sign Out", 3),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {},
          child: const Icon(Icons.person, color: Colors.white), // Cog icon
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  // Navigation Item Builder
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _selectedIndex == index ? Colors.orange : Colors.black),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
