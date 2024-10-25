import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../data/models/response_customer_request_fetching.dart';

class RequestIdText extends StatelessWidget {
  const RequestIdText({
    super.key,
    required this.customerRequest,
  });

  final ResponseCustomerRequestFetching customerRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
          text: 'Request ',
          children: <TextSpan>[
            TextSpan(
              text: customerRequest.id.toString(),
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
