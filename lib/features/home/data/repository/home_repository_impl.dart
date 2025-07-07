import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/utils/graph_config_with_header.dart';
import 'package:e_commerce_web_app/features/home/data/gql/requests.dart';
import 'package:e_commerce_web_app/features/home/data/mapper/mapper.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_result_model.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepositoryImpl implements HomeRepository {
  final GraphQlConfigWithHeader _configWithHeader = GraphQlConfigWithHeader();
  final Dio _dio = Dio();
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
  Future<Either<ApiError, List<DummyProductEntity>>> getProductsByCategory(
    String limit,
    String skip,
  ) async {
    final response = await _dio.get(
      'https://fakestoreapi.com/products?limit=$limit&skip=$skip',
    );
    if (response.statusCode == null) {
      return left(ApiError(message: "No response from server"));
    }
    if (response.statusCode == 200) {
      var data = response.data.map((e) => e.fromApi()).toList();
      return right(data);
    } else {
      return left(ApiError(message: "Something went wrong"));
    }
  }
}
