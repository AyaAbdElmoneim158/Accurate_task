import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class RequestDetailsText extends StatelessWidget {
  const RequestDetailsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          color: AppColors.black,
          size: AppSizes.iconSm,
        ),
        AppSizes.horizontalSpace(AppSizes.sm),
        Text(
          "Request details",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
