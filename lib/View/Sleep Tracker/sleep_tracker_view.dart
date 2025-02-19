import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SleepTracking extends StatefulWidget {
  @override
  _SleepTrackingState createState() => _SleepTrackingState();
}

class _SleepTrackingState extends State<SleepTracking> {
  List<AwakeningEntry> awakenings = [];
  List<NapEntry> naps = [];
  String sleepQuality = "";
  TextEditingController notesController = TextEditingController();
  TextEditingController bedtimeController = TextEditingController();
  TextEditingController wakeupController = TextEditingController();

  void _addAwakening() {
    setState(() {
      awakenings.add(AwakeningEntry(key: GlobalKey<_AwakeningEntryState>()));
    });
  }

  void _addNap() {
    setState(() {
      naps.add(NapEntry(key: GlobalKey<_NapEntryState>()));
    });
  }

  Future<void> _saveData() async {
    CollectionReference sleepRecords = FirebaseFirestore.instance.collection('sleepRecords');
    await sleepRecords.add({
      'bedtime': bedtimeController.text,
      'wakeUp': wakeupController.text,
      'sleepQuality': sleepQuality,
      'awakenings': awakenings.map((a) => a.getData()).toList(),
      'naps': naps.map((n) => n.getData()).toList(),
      'notes': notesController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sleep record saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Tracker")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Sleep Quality", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQualityOption("😫", "Bad"),
                _buildQualityOption("😐", "Okay"),
                _buildQualityOption("😴", "Good"),
              ],
            ),
            SizedBox(height: 16),
            SleepTimeEntry(controller: bedtimeController, title: "Bedtime"),
            SleepTimeEntry(controller: wakeupController, title: "Wake up"),
            SizedBox(height: 16),
            _buildSectionHeader("Night Awakenings", _addAwakening),
            Column(children: awakenings),
            SizedBox(height: 16),
            _buildSectionHeader("Naps", _addNap),
            Column(children: naps),
            SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: "Additional Notes", border: OutlineInputBorder()),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _saveData, child: Text("Save Sleep Record")),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityOption(String emoji, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          sleepQuality = label;
        });
      },
      child: Column(children: [
        Text(emoji, style: TextStyle(fontSize: 50, color: sleepQuality == label ? Colors.amber : Colors.black)),
        Text(label, style: TextStyle(color: sleepQuality == label ? Colors.amber : Colors.black)),
      ]),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
        IconButton(icon: Icon(Icons.add, color: Colors.amber), onPressed: onAdd),
      ],
    );
  }
}

class SleepTimeEntry extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  SleepTimeEntry({required this.controller, required this.title});

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(
          DateTime(picked.year, picked.month, picked.day, time.hour, time.minute),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title, border: OutlineInputBorder()),
      readOnly: true,
      onTap: () => _selectDateTime(context),
    );
  }
}

class AwakeningEntry extends StatefulWidget {
  const AwakeningEntry({required Key key}) : super(key: key);

  Map<String, dynamic> getData() {
    return (key as GlobalKey<_AwakeningEntryState>).currentState!.toMap();
  }

  @override
  _AwakeningEntryState createState() => _AwakeningEntryState();
}

class _AwakeningEntryState extends State<AwakeningEntry> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  Map<String, dynamic> toMap() {
    return {
      'start': startController.text,
      'end': endController.text,
      'notes': notesController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SleepTimeEntry(title: "Start", controller: startController),
        SleepTimeEntry(title: "End", controller: endController),
        TextField(
          controller: notesController,
          decoration: InputDecoration(labelText: "Notes", border: OutlineInputBorder()),
        ),
        Divider(),
      ],
    );
  }
}

class NapEntry extends StatefulWidget {
  const NapEntry({required Key key}) : super(key: key);

  Map<String, dynamic> getData() {
    return (key as GlobalKey<_NapEntryState>).currentState!.toMap();
  }

  @override
  _NapEntryState createState() => _NapEntryState();
}

class _NapEntryState extends State<NapEntry> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  Map<String, dynamic> toMap() {
    return {
      'start': startController.text,
      'end': endController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SleepTimeEntry(title: "Start", controller: startController),
        SleepTimeEntry(title: "End", controller: endController),
        Divider(),
      ],
    );
  }
}