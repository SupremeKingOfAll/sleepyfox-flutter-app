import 'package:flutter/material.dart';

import '../../../Widgets/custom_bottom_nav_bar.dart';
import '../../Dashboard/dashboard_view.dart';
import '../../Settings/settings_view.dart';
import '../../Sleep Tracker/sleep_tracker_view.dart';

class SleepyStory extends StatefulWidget {
  const SleepyStory({super.key});

  @override
  State<SleepyStory> createState() => _SleepyStoryState();
}

class _SleepyStoryState extends State<SleepyStory> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber.shade500,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Sleep Stories",
          style: TextStyle(
            color: const Color.fromARGB(
                255, 252, 174, 41), // Light amber for the subtitle text
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Sleepy fox",
                style: TextStyle(
                  color: const Color.fromARGB(
                      255, 252, 174, 41), // Light amber for the subtitle text
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
            AssetImage('Assets/900w-xy8Cv39_lA0.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(

        ),

      ),

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

}
