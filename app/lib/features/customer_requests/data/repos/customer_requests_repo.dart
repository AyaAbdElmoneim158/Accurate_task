import 'package:dartz/dartz.dart';

import '../models/default_response_customer_request.dart';
import '../models/request_customer_request_saving.dart';
import '../models/response_customer_request_fetching.dart';
import '../models/response_customer_requests_fetching.dart';

/// Abstract class defining the customer requests repository interface.
abstract class CustomerRequestsRepo {
  /// Fetches customer requests based on the provided [typeCode].
  Future<Either<String, ResponseCustomerRequestsFetching>> fetchCustomerRequests(String typeCode);

  /// Fetches paginated customer requests based on the provided [typeCode],
  /// [pageNumber], and [perPage] parameters.
  Future<Either<String, ResponseCustomerRequestsFetching>> fetchCustomerRequestsPaginated(
      String typeCode, int pageNumber, int perPage);

  /// Fetches a specific customer request by its [id].
  Future<Either<String, ResponseCustomerRequestFetching>> fetchCustomerRequest(int id);

  /// Saves a new customer request using the provided [requestCustomerRequestSaving] data.
  Future<Either<String, DefaultResponseCustomerRequest>> saveCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving);

  /// Edits an existing customer request using the provided [requestCustomerRequestSaving] data.
  Future<Either<String, DefaultResponseCustomerRequest>> editCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving);

  /// Cancels a customer request identified by its [id].
  Future<Either<String, DefaultResponseCustomerRequest>> cancelCustomerRequest(int id);
}
