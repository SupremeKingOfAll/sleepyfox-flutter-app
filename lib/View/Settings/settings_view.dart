import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/View/Sleep%20Tracker/sleep_tracker_view.dart';
import 'package:elaros_gp4/Widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SleepTracking()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardView()),
      );
    } else if (index == 2) {
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
                      onTap: () {
                        Navigator.pushNamed(context, '/AccountSettings');
                      },
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
                      leading: Icon(Icons.question_mark,
                          color: Colors.amber, size: 34),
                      title: Text("Guide",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
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

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Navigation Item Builder
}
