import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common/app_list_tile.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helper/function_helper.dart';
import '../../view_model/customer_requests_provider.dart';

class RequestsListView extends StatefulWidget {
  const RequestsListView({super.key});

  @override
  State<RequestsListView> createState() => _RequestsListViewState();
}

class _RequestsListViewState extends State<RequestsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = Provider.of<CustomerRequestProvider>(context, listen: false);

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        provider.customerRequestStatus != CustomerRequestStatus.loading &&
        provider.customerRequests.paginatorInfo.hasMorePages) {
      provider.fetchCustomerRequestsPaginated(provider.typeCode, provider.currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<CustomerRequestProvider>(context);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        // Check if index is the last item and show a loading indicator
        if (index == requestProvider.customerRequests.data.length) {
          return Center(child: FunctionHelper.showLoader());
        }

        final request = requestProvider.customerRequests.data[index];
        return AppListTile(
          title: request.id.toString(),
          subtitle: request.status.name,
          date: DateFormat('yyyy-MM-dd').format(DateTime.parse(request.date)),
          onTap: () => Navigator.of(context).pushNamed(
            '/CustomerRequestsDetails',
            arguments: request.id,
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: AppSizes.dividerHeight,
        color: AppColors.grayDark,
      ),
      itemCount: requestProvider.customerRequests.data.length + 1, // Plus one for loading indicator
    );
  }
}
