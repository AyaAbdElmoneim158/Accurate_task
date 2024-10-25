import 'package:flutter/material.dart';

import '../../../../../core/constants/app_card.dart';
import '../../../../../core/helper/function_helper.dart';
import '../../../data/models/response_customer_request_fetching.dart';

Widget buildRequestDetailsCard(
  BuildContext context,
  ResponseCustomerRequestFetching customerRequest,
) {
  final gridItems = _getGridItems(customerRequest);

  return AppCard(
      child: GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: gridItems.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 2.5,
    ),
    itemBuilder: (context, index) {
      return _buildGridTile(gridItems[index]);
    },
  ));
}

List<Map<String, String>> _getGridItems(ResponseCustomerRequestFetching customerRequest) {
  return [
    {
      "title": "Status",
      "subtitle": customerRequest.status.name,
    },
    {
      "title": "Date",
      "subtitle": FunctionHelper.formatDate(customerRequest.date),
    },
    {
      "title": "Delivery type",
      "subtitle": customerRequest.deliveryType.name,
    },
    {
      "title": "Notes",
      "subtitle": customerRequest.notes,
    },
    {
      "title": "Payee name",
      "subtitle": customerRequest.payeeName,
    },
    {
      "title": "Time",
      "subtitle": FunctionHelper.formatTime(customerRequest.date),
    },
    {
      "title": "Request type",
      "subtitle": customerRequest.type.name,
    },
  ];
}

Widget _buildGridTile(Map<String, String> gridItem) {
  return ListTile(
    title: Text(
      gridItem["title"]!,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(gridItem["subtitle"]!),
  );
}
