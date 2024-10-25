import 'package:accurate_task/core/constants/queries_and_mutations.dart';
import 'package:accurate_task/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constants/colors.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.mapping,
    required this.display,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Map<String, String> mapping;
  final List<String> display;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      isDense: true,
      validator: validator,
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(hintText),
      ),
      icon: Icon(
        MdiIcons.chevronDown,
        color: AppColors.primary,
      ),
      items: getDropdownItems(),
      onChanged: (value) {
        controller.text = mapping[value]!;
      },
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return display.map((String ele) {
      return DropdownMenuItem<String>(
        value: ele,
        child: Text(ele),
      );
    }).toList();
  }
}

Map<String, String> requestTypemapping = {
  'طلب التسويق الماليه': TypeCode.MTRL.name,
  'طلب فلايرات': TypeCode.PMNT.name,
  'طلب المرتجعات': TypeCode.RTRN.name,
};
List<String> requestTypeDisplay = [
  'طلب التسويق الماليه',
  'طلب فلايرات',
  'طلب المرتجعات',
];

Map<String, String> deliveryTypemapping = {
  'مقر الشركة': DeliveryType.OFFICE.name,
  'ارسال مع المندوب': DeliveryType.DELIVERYAGENT.name,
  'Instapy': DeliveryType.INSTPY.name,
  'Smart Wallet': DeliveryType.WALLET.name,
  'Bank Desposit': DeliveryType.BANK.name,
};
List<String> deliveryTypeDisplay = [
  'مقر الشركة',
  'ارسال مع المندوب',
  'Instapy',
  'Smart Wallet',
  'Bank Desposit',
];
