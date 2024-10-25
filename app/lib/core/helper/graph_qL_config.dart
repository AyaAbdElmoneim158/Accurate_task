import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:accurate_task/core/helper/cache_helper.dart';

const String _baseUrl = 'https://accurate.accuratess.com:8001/graphql';

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._();
  GraphQLConfig._();
  factory GraphQLConfig() => _instance;

  late GraphQLClient client;

  Future<String?> _getToken() async {
    // Ensure the token is retrieved correctly from the cache
    debugPrint("_getToken: ${CacheHelper.getData("tokenKey")}");
    return CacheHelper.getData("tokenKey");
  }

  Future<void> init() async {
    String? token = await _getToken();

    // Ensure token is correctly attached to requests
    final httpLink = HttpLink(_baseUrl, defaultHeaders: {});
    final authLink = AuthLink(
        getToken: () async =>
            "Bearer 1002|eKWnhwkL2TWbtHX6DBkXb81WfhqWoIGPk4b4NNWU6422b98d"
        // () async => await 'Bearer $token'
        );
    final link = authLink.concat(httpLink);
    debugPrint("link: ${link.toString()}");

    client = GraphQLClient(
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
