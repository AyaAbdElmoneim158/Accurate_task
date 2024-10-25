import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../view_model/customer_requests_provider.dart';

class FoundResultsText extends StatelessWidget {
  const FoundResultsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<CustomerRequestProvider>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: AppSizes.sm),
        child: Text(
          "Found results ${requestProvider.customerRequests.paginatorInfo.total}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
