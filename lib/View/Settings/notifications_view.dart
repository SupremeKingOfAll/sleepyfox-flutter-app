import 'package:elaros_gp4/Widgets/Text%20Styles/zaks_personal_text_style.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Notifications"),
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
      body: Column(
        children: [
          Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ZaksPersonalTextStyle(text: 'Notifications', textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Switch(value: true, onChanged: (value){}),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
