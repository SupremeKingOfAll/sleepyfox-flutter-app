import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros_gp4/Services/profile_services.dart';
import 'package:elaros_gp4/View/Dashboard/dashboard_view.dart';
import 'package:elaros_gp4/View/Settings/settings_view.dart';
import 'package:elaros_gp4/Services/logout_function.dart';
import 'package:elaros_gp4/Widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for parsing custom date formats i had to use this package

class SleepTrackingOverview extends StatefulWidget {
  const SleepTrackingOverview({super.key});

  @override
  State<SleepTrackingOverview> createState() => _SleepTrackingOverviewState();
}

class _SleepTrackingOverviewState extends State<SleepTrackingOverview> {
  final ProfileServices _profileServices = ProfileServices();
  List<Map<String, dynamic>> _profiles = [];
  List<Map<String, dynamic>> _allRecords = []; // Holds sleep records based on filter
  bool _isLoading = true;
  String? _selectedProfile; // Currently selected child profile
  String _selectedFilter = "This Week";

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  // Fetch profiles from our database and update the ui
  Future<void> _fetchProfiles() async {
    try {
      final profiles = await _profileServices.fetchChildProfilesForCurrentUser();
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

  // get sleep records for a selected profile with the active filter.
  Future<void> _fetchAllRecords(String profileId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();

      // week filter logic
      DateTime? startOfWeek;
      DateTime? endOfWeek;
      if (_selectedFilter == "This Week") {
        startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
        endOfWeek = startOfWeek.add(const Duration(days: 7)); // End of week
      } else if (_selectedFilter == "Last Week") {
        startOfWeek = now.subtract(Duration(days: now.weekday + 6)); // Previous Monday
        endOfWeek = startOfWeek.add(const Duration(days: 7)); // End of last week
      }

      final sleepDateFormat = DateFormat("dd/MM/yyyy HH:mm"); // Matches wakeUp format

      final snapshot = await FirebaseFirestore.instance
          .collection('dailyTracking')
          .where('profileId', isEqualTo: profileId)
          .get();

      final records = snapshot.docs.map((doc) {
        final data = doc.data();
        data['timestamp'] = (data['timestamp'] as Timestamp).toDate(); // getting the timestamp from database, and parse it

        try {
          final wakeUpTime = sleepDateFormat.parse(data['wakeUp']); // Parse wake-up time
          if (_selectedFilter == "All" ||
              (wakeUpTime.isAfter(startOfWeek!) && wakeUpTime.isBefore(endOfWeek!))) {
            return data;
          }
        } catch (e) {
          print("Error parsing wakeUp for doc ${doc.id}: $e");
        }
        return null;
      }).where((record) => record != null).toList();

      setState(() {
        _allRecords = records.cast<Map<String, dynamic>>();
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
      logout(context); // Log out
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardView()),
      ); // Go to Dashboard
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsView()),
      ); // Go to Settings
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (String filter) {
              setState(() {
                _selectedFilter = filter;
              });
              if (_selectedProfile != null) {
                _fetchAllRecords(_selectedProfile!); // get data with new filter
              }
            },
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "All",
                child: Text("All"), // all records
              ),
              const PopupMenuItem<String>(
                value: "This Week",
                child: Text("This Week"), // this week's records
              ),
              const PopupMenuItem<String>(
                value: "Last Week",
                child: Text("Last Week"), // last week's records
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text(_selectedFilter)), // filter in use
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profiles.isEmpty
          ? const Center(child: Text('No profiles available'))
          : Column(
        children: [
          // drop for profile selection
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
                _selectedProfile = newValue; // update profile
              });
              if (_selectedProfile != null) {
                _fetchAllRecords(_selectedProfile!); // get records for new profile
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
        onPressed: () {}, // Placeholder for future action
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