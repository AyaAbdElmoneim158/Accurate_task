import '/core/constants/queries_and_mutations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constants/colors.dart';


class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.mapping,
    required this.display,
    this.readOnly = false,
    this.initialSelectedValue,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Map<String, String> mapping;
  final List<String> display;
  final bool readOnly;
  final String? initialSelectedValue;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();

    // Check if initialSelectedValue or controller.text matches any display item
    _selectedValue = widget.initialSelectedValue ?? widget.controller.text;
    if (_selectedValue != null && widget.display.contains(_selectedValue)) {
      widget.controller.text = widget.mapping[_selectedValue] ?? '';
    } else {
      // Set to null if the initial value doesn't match any items in the display list
      _selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      isExpanded: true,
      isDense: true,
      validator: widget.validator,
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(widget.hintText),
      ),
      icon: Icon(
        MdiIcons.chevronDown,
        color: AppColors.primary,
      ),
      items: getDropdownItems(),
      onChanged: widget.readOnly
          ? null
          : (value) {
              setState(() {
                _selectedValue = value;
                widget.controller.text = widget.mapping[value] ?? '';
              });
            },
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return widget.display.map((String ele) {
      return DropdownMenuItem<String>(
        value: ele,
        child: Text(ele),
      );
    }).toList();
  }
}

// Usage mappings and display lists for AppDropdown
Map<String, String> requestTypeMapping = {
  'طلب التسويق الماليه': TypeCode.MTRL.name,
  'طلب فلايرات': TypeCode.PMNT.name,
  'طلب المرتجعات': TypeCode.RTRN.name,
};

Map<String, String> requestTypeMapping2 = {
  TypeCode.MTRL.name: 'طلب التسويق الماليه',
  TypeCode.PMNT.name: 'طلب فلايرات',
  TypeCode.RTRN.name: 'طلب المرتجعات',
};
List<String> requestTypeDisplay = [
  'طلب التسويق الماليه',
  'طلب فلايرات',
  'طلب المرتجعات',
];

Map<String, String> deliveryTypeMapping = {
  'مقر الشركة': DeliveryType.OFFICE.name,
  'ارسال مع المندوب': DeliveryType.DELIVERYAGENT.name,
  'Instapy': DeliveryType.INSTPY.name,
  'Smart Wallet': DeliveryType.WALLET.name,
  'Bank Desposit': DeliveryType.BANK.name,
};

List<String> deliveryTypeDisplay = [
  'مقر الشركة',
  'ارسال مع المندوب',
];
List<String> deliveryTypePMNTDisplay = [
  'مقر الشركة',
  'ارسال مع المندوب',
  'Instapy',
  'Smart Wallet',
  'Bank Desposit',
];
