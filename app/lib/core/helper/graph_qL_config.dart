import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'cache_helper.dart';
import '../constants/end_points.dart';

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._();
  factory GraphQLConfig() => _instance;

  GraphQLClient? _client;

  GraphQLConfig._();

  GraphQLClient get client {
    assert(_client != null, 'GraphQLClient has not been initialized. Call init() first.');
    return _client!;
  }

  Future<String?> _getToken() async {
    final token = await CacheHelper.getData("tokenKey");
    debugPrint("_getToken: $token");
    return token;
  }

  Future<void> init() async {
    final String? token = await _getToken();
    _client = _createGraphQLClient(token);
  }

  GraphQLClient _createGraphQLClient(String? token) {
    final httpLink = HttpLink(EndPoints.baseUrl);

    final authLink = AuthLink(
        getToken: () async =>
            "Bearer 1002|eKWnhwkL2TWbtHX6DBkXb81WfhqWoIGPk4b4NNWU6422b98d"); // token != null ?  'Bearer $token' : '',

    final link = authLink.concat(httpLink);

    debugPrint("GraphQL link: $link");

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies.safe(
          FetchPolicy.cacheAndNetwork,
          ErrorPolicy.none,
          CacheRereadPolicy.ignoreAll,
        ),
      ),
    );
  }
}
