// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/queries_and_mutations.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helper/function_helper.dart';
import '../view_model/customer_requests_provider.dart';
import '../../../../core/common/app_button.dart';

import 'widgets/request_details_card.dart';
import 'widgets/request_details_text.dart';
import 'widgets/request_id_text.dart';

class CustomerRequestDetailsView extends StatefulWidget {
  const CustomerRequestDetailsView({super.key, required this.id});

  final int id;

  @override
  State<CustomerRequestDetailsView> createState() => _CustomerRequestDetailsViewState();
}

class _CustomerRequestDetailsViewState extends State<CustomerRequestDetailsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<CustomerRequestProvider>(context, listen: false);
      provider.fetchCustomerRequest(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerRequestProvider>(
      builder: (context, provider, child) {
        _listen(context, provider);
        return FullScrollScreenContainer(
          hasHight: true,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          appBar: _buildAppBar(context, provider),
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
        RequestIdText(customerRequest: provider.customerRequest),
        const RequestDetailsText(),
        AppSizes.verticalSpace(AppSizes.sm),
        buildRequestDetailsCard(context, provider.customerRequest),
        AppSizes.verticalSpace(AppSizes.md),
        if (provider.customerRequest.editable == true) _buildCancelButton(context, provider),
      ],
    );
  }

  AppAppBar _buildAppBar(BuildContext context, CustomerRequestProvider provider) {
    return AppAppBar(
      title: "Request details",
      hasLeading: true,
      actions: [
        if (provider.customerRequest.editable == true)
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/CustomerRequestAdditionOrUpdating',
                arguments: {
                  "id": provider.customerRequest.id,
                  "isEdit": true,
                  "request": provider.customerRequest,
                },
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.black,
              size: AppSizes.iconMd,
            ),
          ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context, CustomerRequestProvider provider) {
    return provider.customerRequestStatus == CustomerRequestStatus.cancelling
        ? FunctionHelper.showLoader()
        : AppButton(
            onPressed: () {
              provider.cancelCustomerRequest(widget.id);
              // FunctionHelper.showSnackbar(context, "The request has been cancelled.", AppColors.primary);
              // Navigator.pop(context);
              provider.fetchCustomerRequests(TypeCode.MTRL);
              provider.fetchCustomerRequests(TypeCode.PMNT);
              provider.fetchCustomerRequests(TypeCode.RTRN);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text("Cancel", style: TextStyle(color: Colors.white)),
              ],
            ),
          );
  }

  void _listen(BuildContext context, CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.error && provider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, provider.errorMessage!);
      });
    } else if (provider.customerRequestStatus == CustomerRequestStatus.cancelled) {
      FunctionHelper.showSnackbar(context, "The request has been cancelled.", AppColors.primary);
      Navigator.pop(context);
    }
  }
}
