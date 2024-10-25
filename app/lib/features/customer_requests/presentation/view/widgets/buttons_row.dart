import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/queries_and_mutations.dart';
import '../../../../../core/constants/sizes.dart';
import '../../view_model/button_provider.dart';
import '../../view_model/customer_requests_provider.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context);
    final customerRequestProvider = Provider.of<CustomerRequestProvider>(context);

    return SizedBox(
      height: 75,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ButtonType.values.map((buttonType) {
              return _buildButton(
                context: context,
                label: buttonType.name,
                isSelected: buttonProvider.selectedButton == buttonType,
                onPressed: () {
                  buttonProvider.selectButton(buttonType);
                  customerRequestProvider.fetchCustomerRequests(_mapButtonTypeToTypeCode(buttonType));
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.grey,
        ),
        backgroundColor: isSelected ? Colors.red[50] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.grey,
        ),
      ),
    );
  }

  // Helper function to map ButtonType to TypeCode
  TypeCode _mapButtonTypeToTypeCode(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.Payments:
        return TypeCode.PMNT;
      case ButtonType.Returns:
        return TypeCode.RTRN;
      case ButtonType.Materials:
        return TypeCode.MTRL;
      default:
        throw Exception('Invalid ButtonType');
    }
  }
}
