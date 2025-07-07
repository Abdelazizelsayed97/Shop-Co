import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class GraphQlConfigWithHeader {
  static final GraphQlConfigWithHeader _instance = GraphQlConfigWithHeader._();

  GraphQlConfigWithHeader._();

  factory GraphQlConfigWithHeader() {
    return _instance;
  }

  late GraphQLClient client;
  late Link _link;
  late final AuthLink _authLink;
  late final HttpLink _httpLink;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    _authLink = AuthLink(
      getToken: () async {
        final token = SharedPrefs.getFromShard(key: ConstStrings.token);
        if (token.isNotEmpty) {
          return 'Bearer $token';
        } else {
          return null;
        }
      },
    );

    _httpLink = HttpLink(
      ConstStrings.baseUrl,
      defaultHeaders: {"Apollo-Require-Preflight": "true"},
    );

    // 🌐 Wrap with internet checker link
    final internetCheckLink = InternetCheckLink();

    _link = internetCheckLink.concat(_authLink).concat(_httpLink);

    client = GraphQLClient(
      queryRequestTimeout: Duration(minutes: 10),
      link: _link,
      cache: GraphQLCache(store: InMemoryStore()),
      defaultPolicies: DefaultPolicies(
        watchQuery: Policies(fetch: FetchPolicy.networkOnly),
        mutate: Policies.safe(
          FetchPolicy.networkOnly,
          ErrorPolicy.ignore,
          CacheRereadPolicy.ignoreAll,
        ),
        query: Policies.safe(
          FetchPolicy.networkOnly,
          ErrorPolicy.ignore,
          CacheRereadPolicy.ignoreAll,
        ),
      ),
    );

    _isInitialized = true;
  }
}

// 🔌 Custom Link using internet_connection_checker_plus
class InternetCheckLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final hasConnection = await InternetConnection().hasInternetAccess;

    if (!hasConnection) {
      throw Exception("No internet connection. Request blocked.");
    }

    if (forward != null) {
      yield* forward(request);
    }
  }
}

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    ConstStrings.baseUrl,
    defaultHeaders: {"Apollo-Require-Preflight": "true"},
  );

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
      defaultPolicies: DefaultPolicies(
        mutate: Policies.safe(
          FetchPolicy.networkOnly,
          ErrorPolicy.ignore,
          CacheRereadPolicy.ignoreAll,
        ),
        query: Policies.safe(
          FetchPolicy.networkOnly,
          ErrorPolicy.ignore,
          CacheRereadPolicy.ignoreAll,
        ),
      ),
    ),
  );
}
