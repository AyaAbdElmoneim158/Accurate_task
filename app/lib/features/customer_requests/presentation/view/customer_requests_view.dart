// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helper/function_helper.dart';
import '../view_model/customer_requests_provider.dart';
import 'widgets/buttons_row.dart';
import 'widgets/found_results_text.dart';
import 'widgets/requests_list_view.dart';

class CustomerRequestsView extends StatelessWidget {
  const CustomerRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerRequestProvider>(
      builder: (context, provider, child) {
        _listenForErrors(context, provider);
        return FullScrollScreenContainer(
          hasHight: true,
          padding: EdgeInsets.zero,
          appBar: _buildAppBar(context),
          body: _buildBody(provider),
        );
      },
    );
  }

  AppAppBar _buildAppBar(BuildContext context) {
    return AppAppBar(
      title: AppStrings.requests,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: AppColors.black,
            size: AppSizes.iconMd,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.loading) {
      return Center(child: FunctionHelper.showLoader(size: 64));
    }

    return Column(
      children: [
        const ButtonsRow(),
        AppSizes.verticalSpace(AppSizes.defaultBtwFields),
        const Expanded(
          child: Column(
            children: [
              FoundResultsText(),
              RequestsListView(),
            ],
          ),
        ),
      ],
    );
  }

  void _listenForErrors(BuildContext context, CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.error && provider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, provider.errorMessage!);
      });
    }
  }
}
