import 'package:flutter/material.dart';
import 'package:elaros_gp4/View/SleepStory/Sleep_story_card.dart';

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
  final PageController _pageController = PageController();

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber.shade500,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          "Sleep Stories",
          style: TextStyle(
            color: Color.fromARGB(
                255, 252, 174, 41), // Light amber for the subtitle text
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Sleepy Fox",
                style: TextStyle(
                  color: Color.fromARGB(
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
            image: AssetImage(
                'Assets/900w-xy8Cv39_lA0.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: _pageController,
          children: [
            SleepStoryCard(
              title: 'Sleepy Fox',
              imagePath: 'Assets/900w-xy8Cv39_lA0.png',
              content:
              'Once upon a time, in a quiet meadow wrapped in twilight, there lived a little firefly named Luna. Unlike her friends who loved to race and play, Luna adored watching the stars. Every evening, when the sky turned dark and sprinkled with shimmering lights, Luna would buzz to the tallest blade of grass and gaze upward.',
            next: '01',
            ),
            SleepStoryCard(
              title: 'Starry Night',
              imagePath: 'Assets/FoxMascProfPic.png',
              content:
              'One magical evening, under the soft glow of the moon, Luna discovered a secret about the stars—they whispered dreams to those who listened closely. She floated gently between them, letting their light guide her through her own dazzling adventure.',
              next: '02',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}