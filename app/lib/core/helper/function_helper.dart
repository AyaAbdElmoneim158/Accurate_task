import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/colors.dart';

class FunctionHelper {
  FunctionHelper._();

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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSnackbar(
      BuildContext context, String message, Color? backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Center showLoader({double size = 32}) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.primary,
        size: size,
      ),
    );
  }

  static String formatDate(String dateString) {
    try {
      // Assuming the dateString is in ISO format, adjust if needed
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime); // Format as needed
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }

  static String formatTime(String dateString) {
    try {
      // Assuming the dateString is in ISO format, adjust if needed
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat.jm()
          .format(dateTime); // Format as needed, e.g., "2:05 PM"
    } catch (e) {
      print('Error parsing time: $e');
      return 'Invalid time';
    }
  }
}
