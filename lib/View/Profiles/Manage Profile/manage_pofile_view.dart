import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/Widgets/Buttons/button_guide_style.dart';
import 'package:elaros_gp4/Widgets/Text%20Styles/zaks_personal_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:elaros_gp4/Services/profile_services.dart';
import '../../../Widgets/Buttons/logout_function.dart';

class ManageProfileView extends StatefulWidget {
  const ManageProfileView({super.key});

  @override
  State<ManageProfileView> createState() => _ManageProfileViewState();
}

class _ManageProfileViewState extends State<ManageProfileView> {
  final ProfileServices _profileServices = ProfileServices();
  List<Map<String, dynamic>> _profiles = [];
  bool _isLoading = true;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 4) {
      setState(() {
        logout(context);
      });
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardView()),
      );
    } else if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

//logout function
  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, "/Login");
      print("User logged out");
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  void initState() {
    super.initState();
    _fetchProfiles();
  }

  //Profile fetch
  Future<void> _fetchProfiles() async {
    try {
      List<Map<String, dynamic>> profiles =
          await _profileServices.fetchChildProfilesForCurrentUser();
      setState(() {
        _profiles = profiles;
        _isLoading = false;
      });
    } catch (error) {
      print("Failed to fetch profiles: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  //prof delete
  Future<void> _deleteProfile(String profileId) async {
    try {
      await _profileServices.deleteProfile(profileId);
      await _fetchProfiles(); // Refresh the profiles list after deletion
    } catch (error) {
      print("Failed to delete profile: $error");
    }
  }

  //Not Functional delete profile
  void _handleDeleteProfile() async {
    if (_profiles.isNotEmpty) {
      await _deleteProfile(_profiles[0]['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;

    // Range error before profile fully loads up
    //Needs to be fixed after this sprint week. Sorry guys :(
    if (_profiles.isEmpty || index >= _profiles.length) {
      return Scaffold(
        appBar: AppBar(
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
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final profile = _profiles[index]; // Index of selected profile

    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TOP PROFILE SECTION
            Padding(
              padding: const EdgeInsets.all(8.2),
              child: Card(
                color: Colors.grey[200],
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // PROFILE PICTURE
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          "Assets/SleepyFoxLogo512.png",
                          width: 100,
                          height: 100,
                        ),
                        _isLoading
                            ? CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    ZaksPersonalTextStyle(
                                      text: profile['name'],
                                      textStyle: TextStyle(
                                          fontSize: 40), // Here ProfileIndex
                                    ),
                                    Container(height: 0),
                                    ZaksPersonalTextStyle(
                                      text: "Age: ${profile['age'].toString()}",
                                      //and here as well ProfileIndex
                                      textStyle: TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Decorative Bar
            SizedBox(
              height: 20,
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.2),
            //   child: Card(
            //     color: Colors.grey[200],
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           ZaksPersonalTextStyle(text: 'Sleep Analysis', textStyle: TextStyle(fontSize: 30)),
            //           SizedBox(height: 10),
            //           Container(
            //             padding: EdgeInsets.all(16),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Text('Average Sleep Duration',
            //                     style:
            //                     TextStyle(fontSize: 20, color: Colors.black)),
            //                 SizedBox(height: 5),
            //                 Text('7.5 hours',
            //                     style: TextStyle(
            //                         fontSize: 24, fontWeight: FontWeight.bold)),
            //                 SizedBox(height: 15),
            //                 Divider(
            //                   indent: 10,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: [
            //                     ZaksPersonalTextStyle(text: 'Current Mood:', textStyle: TextStyle(fontSize: 20)),
            //                     ZaksPersonalTextStyle(text: 'Happy', textStyle: TextStyle(fontSize: 18))
            //
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // PROFILE SLEEP ANALYSIS

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //pie chart card
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 300, // Fixed width for the card
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: ZaksPersonalTextStyle(text: 'Sleep Pie', textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 70,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orangeAccent,
                                    value: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 50,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ZaksPersonalTextStyle(text: 'Asleep: 🟢', textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(width: 10,),
                              ZaksPersonalTextStyle(text: 'Awake: 🟠', textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  //Calendar Card
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ZaksPersonalTextStyle(text: 'Sleep Calendar', textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),// Wont let the user scroll the calendar
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7, // 7 columns for days of the week as it was discussed
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              itemCount: 28, // 28 days for 4 weeks of period
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: index % 5 == 0 ? Colors.red : Colors.green,//temp decoration implementation here. index div 5 = 0 then red. else green
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          // Color code explanation part below
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ZaksPersonalTextStyle(
                                    text: 'Excellent: 🟢',
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 20), // Ensure consistent spacing
                                  ZaksPersonalTextStyle(
                                    text: 'Could be better: 🟠',
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ZaksPersonalTextStyle(
                                    text: 'Bad: 🟡',
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 20),
                                  ZaksPersonalTextStyle(
                                    text: 'Really Bad: 🔴',
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50,),

            //Card for the top reasons
            Card(
              color: Colors.grey[200],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Reasons for Waking Up (Last 28 Days)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height: 10),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bathroom',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '8 times',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Divider(),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bad Dream',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '6 times',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Divider(),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '3 times',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    GuideButton(
                      text: 'Share Profile',
                      onPressed: (){},
                    ),
                    SizedBox(height: 10,),
                    GuideButton(
                      text: 'Delete Profile',
                      onPressed: _handleDeleteProfile,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.nightlight_round, "Sleep", 1),
            const SizedBox(width: 48), // Space for floating button
            _buildNavItem(Icons.settings, "Settings", 3),
            _buildNavItem(Icons.logout, "Sign Out", 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 233, 166, 90),
        shape: const CircleBorder(),
        child: Image.asset(
          "Assets/SleepyFoxLogo512.png",
          width: 40,
          height: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isSelected ? Colors.amber.withOpacity(0.2) : Colors.transparent,
        ),
        child: SizedBox(
          height: 56, // OVERFLOW FIX
          width: 60, // same width on all devices
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: isSelected ? 0 : 4, // Moves up when selected
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: isSelected ? 28 : 24, // Adjusts size without scaling
                  child: Icon(icon,
                      color: isSelected ? Colors.amber.shade700 : Colors.black,
                      size: isSelected ? 28 : 24),
                ),
              ),
              Positioned(
                bottom: 0, // Fixes text position
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.amber.shade700 : Colors.black,
                  ),
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
