import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard_viewlist_resources.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.menu,
            color: const Color.fromARGB(255, 202, 126, 33)
            ),
          backgroundColor: const Color.fromARGB(255, 234, 235, 235),
          title: Text("Dashboard"),
          actions: [
            Padding(
              padding: 
                EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Sleepy fox"),
                )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SLIDING FIRST PART OF DASHBOARD
              Container(
                color: Colors.white, // White background
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
              Container(
                height: 200, // Fixed height (adjust as needed)
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'SleepyFox Features',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // SLEEP ANALYSIS PART  
              Container(
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Sleep Analysis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
        FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // LEARN MORE , START TRACKING
              Container(
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Learn More, Start Tracking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
          ],
        ),
      ),
    );
  }
}

