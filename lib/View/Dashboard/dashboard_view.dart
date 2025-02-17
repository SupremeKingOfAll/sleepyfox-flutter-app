import 'package:flutter/material.dart';

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
        body: Column(
          children: [
            // SLIDING FIRST PART OF DASHBOARD
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
              ),
            ),
            // SLEEPYFOX FEATURES PART
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.red,
              ),
            ),
            // SLEEP ANALYSIS PART  
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
              ),
            ),
            // LEARN MORE , START TRACKING
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
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

