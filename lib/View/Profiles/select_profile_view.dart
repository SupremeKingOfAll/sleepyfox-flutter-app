import 'package:elaros_gp4/Widgets/Buttons/button_guide_stule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectProfileView extends StatefulWidget {
  const SelectProfileView({super.key});

  @override
  State<SelectProfileView> createState() => _SelectProfileViewState();
}

class _SelectProfileViewState extends State<SelectProfileView> {
  @override

  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   if (index != 2) {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   }
  // }
  //
  // void _logout(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     Navigator.pushReplacementNamed(context, "/Login");
  //     print("User logged out");
  //   } catch (e) {
  //     print("Error logging out: $e");
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: const Color.fromARGB(255, 202, 126, 33),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Profiles"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //profile section
          Container(
            child: Column(
              children: [
                _profileCard("Zak", "Assets/ProfilePicGirl.png", () {}),
                _profileCard("Mustafa", "Assets/ProfPicKid.png", () {}),
                _profileCard("Khalid", "Assets/ProfilePicMale.png", () {}),
                _profileCard("Sandor", "Assets/FoxMascProfPic.png", () {}),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GuideButton(text: "Create a New Profile", onPressed: (){}),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _profileCard(String title, String imagePath, VoidCallback? onTap) {
  return Card(
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 30),
      onTap: onTap,
    ),
  );
}
