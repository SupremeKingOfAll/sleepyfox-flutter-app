import 'package:elaros_gp4/View/Education/education_view.dart';
import 'package:elaros_gp4/Widgets/Buttons/button_guide_stule.dart';
import 'package:elaros_gp4/Widgets/Buttons/button_start_track_style.dart';
import 'package:flutter/material.dart';
import 'dashboard_viewlist_resources.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: const Color.fromARGB(255, 202, 126, 33),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Dashboard"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LOGO+NAME 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(            
                children: [
                  Image.asset(
                    'Assets/SleepyFoxLogo512.png', // Path to your image
                    width: 40, // Adjust the size as needed
                    height: 40,
                  ),
                  SizedBox(width: 10), // Space between image and text
                  Text(
                    'Ben Smith', // Name text
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // SLIDING FIRST PART OF DASHBOARD
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InfoContainer(
                        title: 'Sleep Hygiene',
                        subtitle: 'Sleeping Techniques',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InfoContainer(
                        title: 'Sleep Cycle',
                        subtitle: 'Deep & REM Sleep',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InfoContainer(
                        title: 'Healthy Habits',
                        subtitle: 'Better Rest Routine',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SLEEPYFOX FEATURES PART
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleepy Fox Features',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  _featureItem('Manage Profiles',null), // CHANGE NULL INTO NAVIGATOR PUSH TO THE FILE, education example
                  _featureItem('Sleep',null),
                  _featureItem('Education',() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EducationView()),
                      );
                    }),
                  _featureItem('Analytics',null),
                  _featureItem('Sleep Tracking',null),
                ],
              ),
            ),

            // Sleep Analysis Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleep Analysis',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Average Sleep Duration',
                            style: TextStyle(fontSize: 16, color: Colors.black54)),
                        SizedBox(height: 5),
                        Text('7.5 hours',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoBox('Sleep Quality', 'Good'),
                            _infoBox('Profile', 'Alex', isButton: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Buttons Section with SizedBox for proper layout
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    //Widget is inside ./widget/buttons
                    GuideButton(text: "LearnMore", onPressed: (){},),
                    SizedBox(height: 10),
                    //Widget is inside ./widget/buttons
                    StartTrackingSleepButton(text: "Start Tracking", onPressed: (){}),
                  ],
                ),
              ),
            ),
          ],
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
            _buildNavItem(Icons.settings, "Settings", 3),
            _buildNavItem(Icons.logout, "Sign Out", 4),
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

  Widget _featureItem(String title, VoidCallback? onTap) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _infoBox(String label, String value, {bool isButton = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black54)),
        SizedBox(height: 4),
        isButton
            ? ElevatedButton(
                onPressed: () {},
                child: Text(value),
              )
            : Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

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
