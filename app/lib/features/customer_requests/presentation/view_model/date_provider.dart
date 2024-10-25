import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider with ChangeNotifier {
  String _formattedDate = '';
  String get formattedDate => _formattedDate;

  /// Opens a date picker dialog and updates the selected date.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await _showDatePicker(context);

    if (pickedDate != null) {
      _updateFormattedDate(pickedDate);
    }
  }

  /// Displays the date picker and returns the selected date.
  Future<DateTime?> _showDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
  }

  /// Updates the formatted date and notifies listeners.
  void _updateFormattedDate(DateTime date) {
    _formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    notifyListeners();
  }
}
