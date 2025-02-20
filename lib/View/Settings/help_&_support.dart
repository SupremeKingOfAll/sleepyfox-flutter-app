import 'package:flutter/material.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  int _selectedIndex = 3; // Default to Help & Support page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //  Add navigation logic here (e.g., Navigator.pushNamed)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Theme background

      //  Top Navigation Bar
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: const Color.fromARGB(255, 202, 126, 33),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 235, 235),
        title: Text("Help & Support"),
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

      // Page Content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 🦊 Logo
              Image.asset(
                'Assets/SleepyFoxLogo512.png',
                width: 120,
                height: 120,
              ),

              const SizedBox(height: 15),

              // 📝 Title
              const Text(
                "Sleepy Fox™",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 5),

              //  Subtitle
              const Text(
                "A pioneering mobile app to support the assessment of children with sleep disorders",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              //  Description
              const Text(
                "Sleep is essential for human survival. Lack of adequate sleep leads to many detrimental health effects. Common behavioural sleep problems include difficulties falling asleep, an inability to maintain sleep and early morning awakenings.\n\n"
                    "Using the Sleepy Fox™ app, carers are taught to understand the science behind sleep and to create a personalised bedtime plan along with strategies to help the child get a good night’s sleep.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),

              const SizedBox(height: 30),

              //  Contact Title
              const Text(
                "Contact",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 15),

              //  Email Button
              ElevatedButton(
                onPressed: () {
                  // Add Email Intent Here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "📧 Email us: hello@elaros.com",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      // 📌 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.nightlight_round, "Sleep", 1),
            const SizedBox(width: 48), // Space for floating button
            _buildNavItem(Icons.settings, "Settings", 2), // Highlighted by default
            _buildNavItem(Icons.logout, "Sign Out", 3),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: const Icon(Icons.help, color: Colors.white), // Help icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 🔹 Navigation Item Builder
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _selectedIndex == index ? Colors.orange : Colors.black),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
