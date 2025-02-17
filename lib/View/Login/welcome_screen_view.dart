import 'package:elaros_gp4/Widgets/text_style_black.dart';
import 'package:flutter/material.dart';

class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({super.key});

  @override
  State<WelcomeScreenView> createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.yellow[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 200,
                      child: Center(
                        child: Column(
                          children: [
                            StrokeText(
                              text: "Sleepy",
                              textStyle: TextStyle(fontSize: 70),
                            ),
                            StrokeText(
                              text: "Fox",
                              textStyle: TextStyle(fontSize: 70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0),
              Container(
                color: Colors.white10,
                child: Column(
                  children: [
                    Text(
                      'Quick Guide',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text('Guide example'),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("Back")),
                        ElevatedButton(onPressed: () {}, child: Text("Next")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
