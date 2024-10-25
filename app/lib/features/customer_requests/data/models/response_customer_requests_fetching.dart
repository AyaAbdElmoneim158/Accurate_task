import 'default_response_customer_request.dart';

class PaginatorInfo {
  final int count;
  final int currentPage;
  final int firstItem;
  final bool hasMorePages;
  final int lastItem;
  final int lastPage;
  final int perPage;
  final int total;

  PaginatorInfo({
    required this.count,
    required this.currentPage,
    required this.firstItem,
    required this.hasMorePages,
    required this.lastItem,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  // Empty constructor
  factory PaginatorInfo.empty() {
    return PaginatorInfo(
      count: 0,
      currentPage: 0,
      firstItem: 0,
      hasMorePages: false,
      lastItem: 0,
      lastPage: 0,
      perPage: 0,
      total: 0,
    );
  }

  // Factory constructor to create the PaginatorInfo from JSON
  factory PaginatorInfo.fromJson(Map<String, dynamic> json) {
    return PaginatorInfo(
      count: json['count'] as int,
      currentPage: json['currentPage'] as int,
      firstItem: json['firstItem'] as int,
      hasMorePages: json['hasMorePages'] as bool,
      lastItem: json['lastItem'] as int,
      lastPage: json['lastPage'] as int,
      perPage: json['perPage'] as int,
      total: json['total'] as int,
    );
  }
}

class ResponseCustomerRequestsFetching {
  final PaginatorInfo paginatorInfo;
  final List<DefaultResponseCustomerRequest> data;

  ResponseCustomerRequestsFetching({
    required this.paginatorInfo,
    required this.data,
  });

  // Empty constructor
  factory ResponseCustomerRequestsFetching.empty() {
    return ResponseCustomerRequestsFetching(
      paginatorInfo: PaginatorInfo.empty(),
      data: [],
    );
  }

  // Factory constructor to create the ResponseCustomerRequestsFetching from JSON
  factory ResponseCustomerRequestsFetching.fromJson(Map<String, dynamic> json) {
    var requestsData = (json['data'] as List)
        .map((requestJson) =>
            DefaultResponseCustomerRequest.fromJson(requestJson))
        .toList();

    return ResponseCustomerRequestsFetching(
      paginatorInfo: PaginatorInfo.fromJson(json['paginatorInfo']),
      data: requestsData,
    );
  }
}
