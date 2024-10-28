// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helper/function_helper.dart';
import '../../data/models/response_customer_request_fetching.dart';
import '../view_model/customer_requests_provider.dart';
import 'widgets/buttons_row.dart';
import 'widgets/found_results_text.dart';
import 'widgets/requests_list_view.dart';

class CustomerRequestsView extends StatefulWidget {
  const CustomerRequestsView({super.key});

  @override
  State<CustomerRequestsView> createState() => _CustomerRequestsViewState();
}

class _CustomerRequestsViewState extends State<CustomerRequestsView> {
  final ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  final int _perPage = 20; // Define how many items per page

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initial fetch
    _fetchPaginatedRequests();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to handle scroll events
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchPaginatedRequests();
    }
  }

  // Function to fetch paginated customer requests
  Future<void> _fetchPaginatedRequests() async {
    final provider =
        Provider.of<CustomerRequestProvider>(context, listen: false);
    if (provider.customerRequestStatus != CustomerRequestStatus.loading) {
      await provider.fetchCustomerRequestsPaginated(
        provider.typeCode,
        _pageNumber,
      );
      setState(() {
        _pageNumber++; // Increment page number for the next load
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerRequestProvider>(
      builder: (context, provider, child) {
        // _listenForErrors(context, provider);
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
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/CustomerRequestAdditionOrUpdating',
              arguments: {
                "isEdit": false,
                "id": 00,
                "request": ResponseCustomerRequestFetching.empty(),
              },
            );
          },
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
    switch (provider.customerRequestStatus) {
      case CustomerRequestStatus.loading:
        return Center(child: FunctionHelper.showLoader(size: 64));

      case CustomerRequestStatus.error:
        return Center(child: FunctionHelper.showLoader(size: 64));

      case CustomerRequestStatus.loaded:
      case CustomerRequestStatus.refresh: // In case refresh behavior is needed
        return Column(
          // Use Column to make Expanded valid
          children: [
            const ButtonsRow(),
            AppSizes.verticalSpace(AppSizes.defaultBtwFields),
            Expanded(
              // Ensures that ListView takes available space
              child: Column(
                children: [
                  const FoundResultsText(),
                  Expanded(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: provider.customerRequests.data.length + 1,
                      itemBuilder: (context, index) {
                        if (index < provider.customerRequests.data.length) {
                          return const RequestsListView();
                        } else if (provider.customerRequestStatus ==
                            CustomerRequestStatus.loading) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FunctionHelper.showLoader(size: 32),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }

  void _listenForErrors(
      BuildContext context, CustomerRequestProvider provider) {
    if (provider.customerRequestStatus == CustomerRequestStatus.error &&
        provider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, provider.errorMessage!);
      });
    }
  }
}
