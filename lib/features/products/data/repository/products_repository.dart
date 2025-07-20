import 'dart:convert' as convert;

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/paginated_data.dart';
import 'package:e_commerce_web_app/features/products/data/mapper/products_mapper.dart';
import 'package:e_commerce_web_app/features/products/domain/entity/product_entity.dart';
import 'package:http/http.dart' as http;

import '../../domain/repository/products_repository.dart';
import '../model/api_fetch_products_result_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  Future<Either<ApiError, PaginatedData<ProductsEntity>>>
  fetchProducts() async {
    var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{http}',
    });
    final response = await http.get(url);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var data = ApiShopCoResultModel.fromJson(jsonResponse);
    if (response.statusCode == 200) {
      return Right(data.convertToEntity());
    } else {
      return Left(ApiError());
    }
  }
}
