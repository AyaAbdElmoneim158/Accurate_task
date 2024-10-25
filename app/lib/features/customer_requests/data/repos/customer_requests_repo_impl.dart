import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../core/constants/queries_and_mutations.dart';
import '../../../../core/helper/graph_ql_config.dart';
import '../models/default_response_customer_request.dart';
import '../models/request_customer_request_saving.dart';
import '../models/response_customer_request_fetching.dart';
import '../models/response_customer_requests_fetching.dart';
import 'customer_requests_repo.dart';

class CustomerRequestsRepoImpl extends CustomerRequestsRepo {
  @override
  Future<Either<String, DefaultResponseCustomerRequest>> cancelCustomerRequest(int id) async {
    return await _executeRequest<DefaultResponseCustomerRequest>(
      AppQueriesAndMutations.customerRequestCancelling,
      {
        "input": {"id": id, "statusCode": "CANCELLED"}
      },
      (data) => DefaultResponseCustomerRequest.fromJson(data["saveCustomerRequest"]),
    );
  }

  @override
  Future<Either<String, DefaultResponseCustomerRequest>> editCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving) async {
    return await _executeRequest<DefaultResponseCustomerRequest>(
      AppQueriesAndMutations.customerRequestEditing,
      {"input": requestCustomerRequestSaving.toJsonEditing()},
      (data) => DefaultResponseCustomerRequest.fromJson(data["saveCustomerRequest"]),
    );
  }

  @override
  Future<Either<String, ResponseCustomerRequestFetching>> fetchCustomerRequest(int id) async {
    return await _executeRequest<ResponseCustomerRequestFetching>(
      AppQueriesAndMutations.customerRequest,
      {"id": id},
      (data) => ResponseCustomerRequestFetching.fromJson(data["customerRequest"]),
    );
  }

  @override
  Future<Either<String, DefaultResponseCustomerRequest>> saveCustomerRequest(
      RequestCustomerRequestSaving requestCustomerRequestSaving) async {
    return await _executeRequest<DefaultResponseCustomerRequest>(
      AppQueriesAndMutations.customerRequestSaving,
      {"input": requestCustomerRequestSaving.toJson()},
      (data) => DefaultResponseCustomerRequest.fromJson(data["saveCustomerRequest"]),
    );
  }

  @override
  Future<Either<String, ResponseCustomerRequestsFetching>> fetchCustomerRequests(String typeCode) async {
    return await _executeRequest<ResponseCustomerRequestsFetching>(
      AppQueriesAndMutations.customerRequests,
      {"typeCode": typeCode, "first": 10, "page": 1},
      (data) => ResponseCustomerRequestsFetching.fromJson(data["listCustomerRequests"]),
    );
  }

  @override
  Future<Either<String, ResponseCustomerRequestsFetching>> fetchCustomerRequestsPaginated(
      String typeCode, int pageNumber, int perPage) async {
    return await _executeRequest<ResponseCustomerRequestsFetching>(
      AppQueriesAndMutations.customerRequests,
      {"typeCode": typeCode, "page": pageNumber, "first": perPage},
      (data) => ResponseCustomerRequestsFetching.fromJson(data["listCustomerRequests"]),
    );
  }

  Future<Either<String, T>> _executeRequest<T>(
    String document,
    Map<String, dynamic> variables,
    T Function(Map<String, dynamic>) handleData,
  ) async {
    try {
      final QueryOptions options = QueryOptions(document: gql(document), variables: variables);
      final request = await GraphQLConfig().client.query(options);

      // Handle GraphQL exceptions
      if (request.exception != null) {
        _handleGraphQLException(request.exception!);
      }

      final data = request.data;
      debugPrint("Data of $document: $data");

      if (data != null) {
        return Right(handleData(data));
      } else {
        return const Left("No Data....!");
      }
    } catch (e) {
      return _handleException(e);
    }
  }

  void _handleGraphQLException(OperationException exception) {
    if (exception.linkException != null) {
      throw exception.linkException!;
    }
    debugPrint("GraphQL Exception: ${exception.toString()}");
  }

  Either<String, T> _handleException<T>(Object e) {
    if (e is LinkException) {
      if (e is ServerException) {
        return Left(e.parsedResponse?.response["message"] ?? "Something went wrong");
      }
    }
    return const Left("Something went wrong, please try again...!");
  }
}
