import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common/app_list_tile.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../data/models/default_response_customer_request.dart';
import '../../view_model/customer_requests_provider.dart';

class RequestsListView extends StatelessWidget {
  const RequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<CustomerRequestProvider>(context);
    final requests = requestProvider.customerRequests.data;

    return Expanded(
      child: ListView.separated(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return _buildRequestTile(context, requests[index]);
        },
        separatorBuilder: (context, index) => Divider(
          height: AppSizes.dividerHeight,
          color: AppColors.grayDark,
        ),
      ),
    );
  }

  Widget _buildRequestTile(BuildContext context, DefaultResponseCustomerRequest request) {
    return AppListTile(
      title: request.id.toString(),
      subtitle: request.status.name,
      date: _formatDate(request.date),
      onTap: () => _navigateToDetails(context, request.id),
    );
  }

  String _formatDate(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  void _navigateToDetails(BuildContext context, int requestId) {
    Navigator.of(context).pushNamed(
      '/CustomerRequestsDetails',
      arguments: requestId,
    );
  }
}
