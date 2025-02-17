import 'package:flutter/material.dart';

class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({super.key});

  @override
  State<WelcomeScreenView> createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                child: Text('Sleepy Fox'),
              ),
              Container(
                child: Text('Sleepy Fox'),
              ),
            ],
          )
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text('Quick Quide'),
                  Container(
                    child: Text('Quide example'),
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Back")),
                      ElevatedButton(onPressed: (){}, child: Text("Next"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
