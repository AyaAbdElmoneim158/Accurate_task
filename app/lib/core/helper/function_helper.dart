import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/colors.dart';

class FunctionHelper {
  FunctionHelper._();

  // Show an error dialog with the specified message
  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // Show a snackbar with the specified message and background color
  static void showSnackbar(BuildContext context, String message, Color? backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Show a loading animation
  static Center showLoader({double size = 32}) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.primary,
        size: size,
      ),
    );
  }

  // Format a date string to 'yyyy-MM-dd'
  static String formatDate(String dateString) {
    return _formatDate(dateString, 'yyyy-MM-dd');
  }

  // Format a date string to time (e.g., "2:05 PM")
  static String formatTime(String dateString) {
    return _formatDate(dateString, DateFormat.jm().pattern!);
  }

  // Helper function to parse and format date strings
  static String _formatDate(String dateString, String format) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat(format).format(dateTime);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return format == 'yyyy-MM-dd' ? 'Invalid date' : 'Invalid time';
    }
  }
}
