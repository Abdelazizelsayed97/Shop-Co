import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/features/home/data/models/api_fetch_products_model_result.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';
import 'package:e_commerce_web_app/features/products/data/mapper/products_mapper.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HttpService _httpService = HttpService();

  @override
  Future<Either<ApiError, List<ProductEntityModel>>> getProductsByCategory(
    String limit,
    String skip,
  ) async {
    final response = await _httpService.get(
      "${AuthEndPoints.productsEndPoint}?limit=$limit&skip=$skip",
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      return left(ApiError(message: "No response from server"));
    } else {
      var data =
          ApiProductResultModel.fromJson(jsonDecode(response.body)).products;
      if (response.statusCode == 200) {
        return right(data?.map((e) => e.fromApiModel()).toList() ?? []);
      } else {
        return left(ApiError(message: "Something went wrong"));
      }
    }
  }
}
