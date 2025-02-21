import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/Widgets/Buttons/logout_function.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 2; // Default to Settings page

void _onItemTapped(int index) {
  if (index == 4) {
    setState(() {
      logout(context);
    });
  } else if (index == 0) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardView()),
    );
  } else if (index == 3) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SettingsView()),
    );
  } else if (index != 2) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Theme color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Settings"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("Sleepy fox"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), // Reduce side padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sleepy Fox Icon
              SizedBox(height: 30),
              Image.asset(
                'Assets/SleepyFoxLogo512.png',
                width: 100, // Bigger icon
                height: 100,
              ),

              const SizedBox(height: 20), // More spacing

              // 🟡 Full-width Expanded Settings Box
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items left
                  children: [
                    //  Move Settings title up
                    Center(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 28, // Bigger text
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12), // Reduced spacing
                    const Divider(color: Colors.black54),

                    // Move ListTiles up & Expand their area
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.amber, size: 34), // Bigger Icon
                      title: Text("Account", style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications, color: Colors.amber, size: 34),
                      title: Text("Notifications", style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.amber, size: 34),
                      title: Text("Privacy", style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.help, color: Colors.amber, size: 34),
                      title: Text("About Us", style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
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
        child: const Icon(Icons.settings, color: Colors.white), // Cog icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
