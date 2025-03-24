import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/Services/logout_function.dart';
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
          padding:
              const EdgeInsets.symmetric(horizontal: 10), // Reduce side padding
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
                height: 450, // Increased height
                padding: const EdgeInsets.symmetric(
                    vertical: 40, horizontal: 25), // More padding inside
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items left
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
                      leading: Icon(Icons.person,
                          color: Colors.amber, size: 34), // Bigger Icon
                      title: Text("Account",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications,
                          color: Colors.amber, size: 34),
                      title: Text("Notifications",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.amber, size: 34),
                      title: Text("Privacy",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.question_mark, color: Colors.amber, size: 34),
                      title: Text("Guide", style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {
                        Navigator.pushNamed(context, '/GuideView');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.help, color: Colors.amber, size: 34),
                      title: Text("About Us",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      onTap: () {
                        Navigator.pushNamed(context, '/AboutUs');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.swap_horizontal_circle_rounded,
                          color: Colors.amber, size: 34),
                      title: Text("Dark Mode",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
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
            _buildNavItem(
                Icons.settings, "Settings", 2), // Highlighted by default
            _buildNavItem(Icons.logout, "Sign Out", 3),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 233, 166, 90),
        shape: const CircleBorder(),
        child: Image.asset(
          "Assets/SleepyFoxLogo512.png",
          width: 40,
          height: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Navigation Item Builder
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
          color:
              isSelected ? Colors.amber.withOpacity(0.2) : Colors.transparent,
        ),
        child: SizedBox(
          height: 56, // OVERFLOW FIX
          width: 60, // same width on all devices
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: isSelected ? 0 : 4, // Moves up when selected
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: isSelected ? 28 : 24, // Adjusts size without scaling
                  child: Icon(icon,
                      color: isSelected ? Colors.amber.shade700 : Colors.black,
                      size: isSelected ? 28 : 24),
                ),
              ),
              Positioned(
                bottom: 0, // Fixes text position
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.amber.shade700 : Colors.black,
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
