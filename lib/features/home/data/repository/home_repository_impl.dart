import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/core/utils/graph_config_with_header.dart';
import 'package:e_commerce_web_app/features/home/data/gql/requests.dart';
import 'package:e_commerce_web_app/features/home/data/mapper/mapper.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_model_result.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepositoryImpl implements HomeRepository {
  final GraphQlConfigWithHeader _configWithHeader = GraphQlConfigWithHeader();
  final HttpService _httpService = HttpService();
  HomeRepositoryImpl() {
    init();
  }

  void init() {
    _configWithHeader.init();
  }

  @override
  Future<Either<ApiError, List<ProductEntity>>> getProducts() async {
    final result = await _configWithHeader.client.query(
      QueryOptions(document: gql(getProductsQuery)),
    );
    if (result.hasException) {
      print('failure: ${result.exception}');
      return left(ApiError(message: "Something went wrong"));
    } else {
      final data = ApiFetchProductsResultModel.fromJson(result.data!).products;
      print('success: ${data?.map((e) => e.fromApi()).toList()}');
      if (data?.isNotEmpty ?? false) {
        return right(data!.map((e) => e.fromApi()).toList());
      } else {
        return left(ApiError(message: "No data found"));
      }
    }
  }

  @override
  Future<Either<ApiError, List<ProductEntityModel>>> getProductsByCategory(
    String limit,
    String skip,
  ) async {
    print('impl ----- =====');
    final response = await _httpService.get(
      // 'https://fakestoreapi.com/products?limit=$limit&skip=$skip',
      "${AuthEndPoints.productsEndPoint}?limit=$limit&skip=$skip",
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      return left(ApiError(message: "No response from server"));
    } else {
      print("responseresponseresponseresponse ${response.body}");
      var data =
          ApiProductResultModel.fromJson(jsonDecode(response.body)).products;
      print("responseresponseresponseresponse ${data?.map((e) => e).toList()}");
      if (response.statusCode == 200) {
        return right(data?.map((e) => e.fromApi()).toList() ?? []);
      } else {
        return left(ApiError(message: "Something went wrong"));
      }
    }
  }
}
