import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/dio_service.dart';
import 'package:e_commerce_web_app/features/cart/data/mapper/product_model_mapper.dart';
import 'package:e_commerce_web_app/features/cart/data/models/ai_cart_result_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/const_strings.dart';
import '../../domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  HttpService client = HttpService();
  @override
  Future<Either<ApiError, ProductEntityModel>> addToCart(String productId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, List<ProductEntityModel>>> fetchCart(
    String userId,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse("${appEndpoint}cart/$userId"),
      headers: headers,
    );
    print('---- ${response.body}');
    final data = ApiCartItemsResultModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(response.body);
      return Right(
        data.products?.map((e) => e.toProductEntity()).toList() ?? [],
      );
    } else {
      print(response.reasonPhrase);
      return Left(ApiError(message: data.message ?? ""));
    }
  }

  @override
  Future<Either<ApiError, Unit>> removeFromCart(String productId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }
}
