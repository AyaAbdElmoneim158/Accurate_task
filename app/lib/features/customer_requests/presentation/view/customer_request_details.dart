// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helper/function_helper.dart';
import '../../data/models/response_customer_request_fetching.dart';
import '../view_model/customer_requests_provider.dart';
import 'widgets/request_details_card.dart';
import 'widgets/request_details_text.dart';
import 'widgets/request_id_text.dart';

class CustomerRequestDetailsView extends StatelessWidget {
  const CustomerRequestDetailsView({
    super.key,
    required this.customerRequest,
  });

  final ResponseCustomerRequestFetching customerRequest;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerRequestProvider>(
      builder: (context, provider, child) {
        _listen(context, provider);
        return FullScrollScreenContainer(
          hasHight: true,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          appBar: _buildAppBar(context),
          body: _buildBody(context, provider),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.loading) {
      return Expanded(child: FunctionHelper.showLoader(size: 64));
    }

    return Column(
      children: [
        RequestIdText(customerRequest: customerRequest),
        const RequestDetailsText(),
        AppSizes.verticalSpace(AppSizes.sm),
        buildRequestDetailsCard(context, customerRequest),
        AppSizes.verticalSpace(AppSizes.md),
      ],
    );
  }

  AppAppBar _buildAppBar(BuildContext context) {
    return const AppAppBar(
      title: "Request details",
      hasLeading: true,
      actions: [],
    );
  }

  void _listen(BuildContext context, CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.error && provider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, provider.errorMessage!);
      });
    } else if (provider.customerRequestStatus == CustomerRequestStatus.cancelled) {
      FunctionHelper.showSnackbar(
        context,
        "The request has been cancelled.",
        AppColors.primary,
      );
      provider.fetchCustomerRequest(customerRequest.id);
    }
  }
}
