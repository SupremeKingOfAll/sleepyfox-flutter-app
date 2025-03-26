import 'package:flutter/material.dart';

class SleepStoryView extends StatefulWidget {
  const SleepStoryView({super.key});

  @override
  State<SleepStoryView> createState() => _SleepStoryViewState();
}

class _SleepStoryViewState extends State<SleepStoryView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber.shade500,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text("Profiles",
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
              child: Text("Sleepy fox",                style: TextStyle(
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
        child: Column(

        ),
      ),
    );
  }
}
