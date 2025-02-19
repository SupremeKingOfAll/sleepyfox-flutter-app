import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TimeInputField({Key? key, required this.label, required this.controller}) : super(key: key);

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime dateTime = DateTime(
          pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute,
        );
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () => _selectDateTime(context),
    );
  }
}
