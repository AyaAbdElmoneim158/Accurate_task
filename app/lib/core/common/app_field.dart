import 'package:accurate_task/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class AppField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final String hintText;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // final String? initialValue;

  const AppField({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.readOnly = false,
    this.isPasswordField = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    // this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AppFieldState createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  bool _hidePassword = true;
  Icon _icon = const Icon(Icons.visibility_off);

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
      _icon = _hidePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      style: const TextStyle(
        fontSize: AppSizes.fontSizeMd,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.hintText,
        suffixIcon: (widget.isPasswordField)
            ? IconButton(
                onPressed: _togglePasswordVisibility,
                icon: _icon,
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
      // initialValue: widget.initialValue ?? '',
      obscureText: (widget.isPasswordField) ? _hidePassword : false,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
    );
  }
}
