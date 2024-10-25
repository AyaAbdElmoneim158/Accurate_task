import 'package:flutter/material.dart';

enum ButtonType { Payments, Returns, Materials }

class ButtonProvider with ChangeNotifier {
  ButtonType _selectedButton = ButtonType.Payments;

  /// Gets the currently selected button type.
  ButtonType get selectedButton => _selectedButton;

  /// Selects a button type and notifies listeners about the change.
  void selectButton(ButtonType buttonType) {
    if (_selectedButton != buttonType) {
      _selectedButton = buttonType;
      notifyListeners();
    }
  }
}
