import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
        body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView to make it scrollable
          child: Column(
            children: [
              // SLIDING FIRST PART OF DASHBOARD (Horizontal Scroll)
              Container(
                height: 150, // Fixed height for the horizontally scrolling part
                color: Colors.blue,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,  // Ensures the ListView only takes up necessary space
                  children: [
                    Container(
                      width: 350,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 350,
                    ),
                    Container(
                      width: 350,
                      color: Colors.indigoAccent,
                    ),
                  ],
                ),
              ),

              // SLEEPYFOX FEATURES PART (Vertical Scroll)
              Container(
                height: 200,  // Height for this part
                color: Colors.red,
              ),

              // SLEEP ANALYSIS PART  
              Container(
                height: 150,  // Height for this part
                color: Colors.blue,
              ),

              // LEARN MORE, START TRACKING
              Container(
                height: 100,  // Height for this part
                color: Colors.green,
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

