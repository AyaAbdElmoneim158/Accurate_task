import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        //! ADD:  ----------------------------------------------------------------------------------
        color: AppColors.grayLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
