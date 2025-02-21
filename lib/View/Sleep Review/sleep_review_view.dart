
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros_gp4/Services/profile_services.dart';
import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/View/Settings/settings_view.dart';
import 'package:elaros_gp4/Widgets/Buttons/logout_function.dart';
import 'package:elaros_gp4/Widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SleepTrackingOverview extends StatefulWidget {
  const SleepTrackingOverview({super.key});

  @override
  State<SleepTrackingOverview> createState() => _SleepTrackingOverviewState();
}

class _SleepTrackingOverviewState extends State<SleepTrackingOverview> {
  final ProfileServices _profileServices = ProfileServices();
  List<Map<String, dynamic>> _profiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

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

  Stream<QuerySnapshot> _fetchSleepRecords(String profileId) {
    return FirebaseFirestore.instance
        .collection('dailyTracking')
        .where('profileId', isEqualTo: profileId)
        .snapshots();
  }

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
  } else if (index == 3) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SettingsView()),
    );
  } else if (index != 2) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Sleep History"),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profiles.isEmpty
              ? const Center(child: Text('No profiles available'))
              : ListView.builder(
                  itemCount: _profiles.length,
                  itemBuilder: (context, index) {
                    final profile = _profiles[index];
                    final profileId = profile['name'];
                    return ExpansionTile(
                      title: Text(profile['name'], style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.amber)),
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _fetchSleepRecords(profileId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No records found'),
                              );
                            }

                            final records = snapshot.data!.docs;

                            return Column(
                              children: records.map((record) {
                                final data = record.data() as Map<String, dynamic>;
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  child: ListTile(
                                    title: Text('Sleep Quality: ${data['sleepQuality'] ?? 'N/A'}'),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Bedtime: ${data['bedtime'] ?? 'N/A'}'),
                                        Text('Wake Up: ${data['wakeUp'] ?? 'N/A'}'),
                                        Text('Notes: ${data['notes'] ?? 'N/A'}'),
                                        Text('Awakenings: ${data['awakenings']?.length ?? 0}'),
                                        Text('Naps: ${data['naps']?.length ?? 0}'),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                bottomNavigationBar: CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
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
}