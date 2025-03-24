import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros_gp4/Services/profile_services.dart';
import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/View/Settings/settings_view.dart';
import 'package:elaros_gp4/Services/logout_function.dart';
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
  // store all records fetched from firestore
  List<Map<String, dynamic>> _allRecords = [];
  bool _isLoading = true;
  String? _selectedProfile;

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

  Future<void> _fetchAllRecords(String profileId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('dailyTracking')
          .where('profileId', isEqualTo: profileId)
          .get();

      final records = snapshot.docs.map((doc) {
        final data = doc.data();
        data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
        return data;
      }).toList();

      setState(() {
        _allRecords = records;
        _isLoading = false;
      });
    } catch (error) {
      print("Failed to fetch records: $error");
      setState(() {
        _isLoading = false;
      });
    }
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
        title: const Text("Sleep History"),
        actions: const [
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
          : Column(
        children: [
          // Dropdown for selecting a profile
          DropdownButton<String>(
            value: _selectedProfile,
            hint: const Text("Select a Profile"),
            items: _profiles.map<DropdownMenuItem<String>>((profile) {
              return DropdownMenuItem<String>(
                value: profile['name'],
                child: Text(
                  profile['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedProfile = newValue;
              });
              if (_selectedProfile != null) {
                _fetchAllRecords(_selectedProfile!);
              }
            },
          ),
          Expanded(
            child: _allRecords.isEmpty
                ? const Center(child: Text('No records found'))
                : ListView.builder(
              itemCount: _allRecords.length,
              itemBuilder: (context, index) {
                final record = _allRecords[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                        'Sleep Quality: ${record['sleepQuality'] ?? 'N/A'}'),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Bedtime: ${record['bedtime'] ?? 'N/A'}'),
                        Text(
                            'Wake Up: ${record['wakeUp'] ?? 'N/A'}'),
                        Text(
                            'Notes: ${record['notes'] ?? 'N/A'}'),
                        Text(
                            'Awakenings: ${record['awakenings']?.length ?? 0}'),
                        Text(
                            'Naps: ${record['naps']?.length ?? 0}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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