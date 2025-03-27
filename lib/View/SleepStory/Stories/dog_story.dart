import 'package:flutter/material.dart';

import '../../../Widgets/custom_bottom_nav_bar.dart';
import '../../Dashboard/dashboard_view.dart';
import '../../Settings/settings_view.dart';
import '../../Sleep Tracker/sleep_tracker_view.dart';
import '../Sleep_story_card.dart';

class DogStory extends StatefulWidget {
  const DogStory({super.key});

  @override
  State<DogStory> createState() => _SleepyStoryState();
}

class _SleepyStoryState extends State<DogStory> {
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
        child: PageView(
          children: [
            SleepStoryCard(
              title: 'Barkley’s Big Day',
              imagePath: 'Assets/BarkleyDog.png',
              content:
              'In a sunny little village, there lived a cheerful dog named Barkley. He had the fluffiest ears, the waggiest tail, and a heart full of curiosity.',
              contenttwo:
              'Barkley loved going on adventures, but his favorite thing in the whole world was making new friends. He believed every day could bring a special surprise.',
              next: 'One morning, Barkley noticed something unusual...',
            ),

            SleepStoryCard(
              title: 'The Mysterious Feather',
              imagePath: 'Assets/Feather.png',
              content:
              'On the dewy grass of his yard lay a shimmering, colorful feather. Barkley sniffed it with wonder. "Who could this belong to?" he thought.',
              contenttwo:
              'Determined to solve the mystery, Barkley set off with the feather tucked under his collar, his nose twitching and tail wagging in excitement.',
              next: 'Barkley’s journey led him to a lively forest...',
            ),

            SleepStoryCard(
              title: 'Forest Friends',
              imagePath: 'Assets/ForestFriends.png',
              content:
              'In the forest, Barkley met a chattering squirrel, a wise old turtle, and a shy bunny. He showed them the feather, and each of them had a guess.',
              contenttwo:
              '"Maybe it’s from the peacock by the pond!" the squirrel suggested. "Or perhaps from the eagle on the cliff," added the turtle. Barkley’s adventure continued with his new friends by his side.',
              next: 'Finally, they reached the sparkling pond...',
            ),

            SleepStoryCard(
              title: 'The Feather’s Home',
              imagePath: 'Assets/Peacock.png',
              content:
              'At the pond, they found a magnificent peacock fanning his tail feathers. "Oh, thank you for finding my lost feather!" the peacock said, bowing graciously.',
              contenttwo:
              'Barkley wagged his tail with pride. He had solved the mystery and made a new friend in the process. As the sun set, he trotted home, dreaming of more adventures to come.',
              next: 'Barkley couldn’t wait to see what surprises tomorrow would bring...',
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
