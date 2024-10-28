import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/queries_and_mutations.dart';
import '../../data/models/default_response_customer_request.dart';
import '../../data/models/request_customer_request_saving.dart';
import '../../data/models/response_customer_request_fetching.dart';
import '../../data/models/response_customer_requests_fetching.dart';
import '../../data/repos/customer_requests_repo.dart';

enum CustomerRequestStatus {
  initial,
  loading,
  loaded,
  refresh,
  error,
  cancelling,
  cancelled,
  saving,
  saved,
  editing,
  edited,
}

class CustomerRequestProvider with ChangeNotifier {
  ResponseCustomerRequestsFetching customerRequests =
      ResponseCustomerRequestsFetching.empty();
  ResponseCustomerRequestFetching customerRequest =
      ResponseCustomerRequestFetching.empty();
  DefaultResponseCustomerRequest defaultCustomerRequest =
      DefaultResponseCustomerRequest.empty();
  TypeCode typeCode = TypeCode.PMNT;

  CustomerRequestStatus _customerRequestStatus = CustomerRequestStatus.initial;
  String? _errorMessage;
  final CustomerRequestsRepo _customerRequestRepo;

  CustomerRequestProvider(this._customerRequestRepo);

  CustomerRequestStatus get customerRequestStatus => _customerRequestStatus;
  String? get errorMessage => _errorMessage;

  // Helper function to set status and log changes
  void _setCustomerRequestStatus(CustomerRequestStatus newStatus) {
    debugPrint("Transition: $_customerRequestStatus --> $newStatus");
    _customerRequestStatus = newStatus;
    notifyListeners();
  }

  // Fetch multiple customer requests
  Future<void> fetchCustomerRequests(TypeCode typeCode) async {
    _setCustomerRequestStatus(CustomerRequestStatus.loading);
    customerRequests = ResponseCustomerRequestsFetching.empty();

    final result =
        await _customerRequestRepo.fetchCustomerRequests(typeCode.name);
    _handleResult(result, (customerRequests) {
      this.customerRequests = customerRequests;
      _setCustomerRequestStatus(CustomerRequestStatus.loaded);
    });
  }

  // Fetch customer requests with pagination
  int currentPage = 1;
  Future<void> fetchCustomerRequestsPaginated(
      TypeCode typeCode, int perPage) async {
    if (customerRequests.paginatorInfo.hasMorePages) {
      final nextPage = customerRequests.paginatorInfo.currentPage + 1;
      final result = await _customerRequestRepo.fetchCustomerRequestsPaginated(
        typeCode.name,
        nextPage,
        perPage,
      );

      _handleResult(result, (newCustomerRequests) {
        customerRequests = ResponseCustomerRequestsFetching(
          paginatorInfo: newCustomerRequests.paginatorInfo,
          data: [...customerRequests.data, ...newCustomerRequests.data],
        );
        _setCustomerRequestStatus(CustomerRequestStatus.loaded);
      });
    }
  }

  // Fetch a specific customer request by ID
  Future<void> fetchCustomerRequest(int id) async {
    _setCustomerRequestStatus(CustomerRequestStatus.loading);
    customerRequest = ResponseCustomerRequestFetching.empty();

    final result = await _customerRequestRepo.fetchCustomerRequest(id);
    _handleResult(result, (customerRequest) {
      this.customerRequest = customerRequest;
      _setCustomerRequestStatus(CustomerRequestStatus.loaded);
    });
  }

  // Cancel a customer request by ID
  Future<void> cancelCustomerRequest(int id) async {
    _setCustomerRequestStatus(CustomerRequestStatus.cancelling);

    final result = await _customerRequestRepo.cancelCustomerRequest(id);
    _handleResult(result, (cancelledRequest) {
      defaultCustomerRequest = cancelledRequest;
      _setCustomerRequestStatus(CustomerRequestStatus.cancelled);
    });
  }

  // Save a customer request
  Future<void> saveCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving) async {
    _setCustomerRequestStatus(CustomerRequestStatus.saving);

    final result = await _customerRequestRepo
        .saveCustomerRequest(requestCustomerRequestSaving);
    _handleResult(result, (savedRequest) {
      defaultCustomerRequest = savedRequest;
      _setCustomerRequestStatus(CustomerRequestStatus.saved);
    });
  }

  // Edit a customer request
  Future<void> editCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving) async {
    _setCustomerRequestStatus(CustomerRequestStatus.editing);

    final result = await _customerRequestRepo
        .editCustomerRequest(requestCustomerRequestSaving);
    _handleResult(result, (editedRequest) {
      defaultCustomerRequest = editedRequest;
      _setCustomerRequestStatus(CustomerRequestStatus.edited);
    });
  }

  // Helper function to handle the result of API calls
  void _handleResult<T>(Either<String, T> result, Function(T) onSuccess) {
    result.fold(
      (error) {
        _errorMessage = error;
        _setCustomerRequestStatus(CustomerRequestStatus.error);
      },
      (data) => onSuccess(data),
    );
  }
}
