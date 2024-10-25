import 'package:accurate_task/core/helper/graph_qL_config.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/queries_and_mutations.dart';
import '../../../../core/helper/cache_helper.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<String, LoginResponse>> login(LoginRequest loginRequest) async {
    final QueryOptions options = QueryOptions(
      document: gql(AppQueriesAndMutations.login),
      variables: {"input": loginRequest.toJson()},
    );
    try {
      final request = await GraphQLConfig().client.query(options);
      if (request.exception != null &&
          request.exception!.linkException != null) {
        throw request.exception!.linkException!;
      } else {
        final data = request.data;
        debugPrint("Data: $data");
        if (data != null) {
          LoginResponse loginResponse = LoginResponse.fromJson(data);
          debugPrint("tokenKey that saved: ${loginResponse.token}");

          CacheHelper.saveData("tokenKey", loginResponse.token);
          return Right(loginResponse);
        } else {
          return const Left("No Data....!");
        }
      }
    } catch (e) {
      if (e is LinkException) {
        if (e is ServerException) {
          return Left(
              e.parsedResponse?.response["message"] ?? "Something went wrong");
        }
      }
      return const Left("Something went wrong, please try again...!");
    }
  }

  @override
  bool authenticated() {
    var token = CacheHelper.getData("tokenKey");
    debugPrint("authenticated at AuthRepoImpl :$token");
    return token != null;
  }
}
