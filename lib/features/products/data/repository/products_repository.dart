import 'dart:convert' as convert;
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/paginated_data.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/features/products/data/mapper/products_mapper.dart';

import '../../../home/data/models/api_fetch_products_model_result.dart';
import '../../domain/repository/products_repository.dart';
import '../model/api_get_product_by_id.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final HttpService _httpService = HttpService();
  @override
  Future<Either<ApiError, PaginatedData<ProductEntityModel>>>
  fetchProducts() async {
    final response = await _httpService.get(AuthEndPoints.productsEndPoint);

    var data = ApiProductResultModel.fromJson(
      convert.jsonDecode(response.body),
    );
    if (response.statusCode == 200) {
      return Right(data.toEntity());
    } else {
      return Left(ApiError());
    }
  }

  @override
  Future<Either<ApiError, ProductEntityModel>> getProductById(String id) async {
    final response = await _httpService.get(
      "${AuthEndPoints.productsEndPoint}/$id",
    );
    final data = ApiGetProductByIdResultModel.fromJson(
      jsonDecode(response.body),
    );
    if (response.statusCode == 200) {
      return Right(data.product?.fromApiModel() ?? ProductEntityModel());
    } else {
      return Left(ApiError(message: data.message));
    }
  }
}
