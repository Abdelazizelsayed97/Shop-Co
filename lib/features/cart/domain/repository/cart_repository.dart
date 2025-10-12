import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';

abstract class CartRepository {
  Future<Either<ApiError, List<ProductEntityModel>>> fetchCart(String userId);
  Future<Either<ApiError, void>> addToCart(String productId);
  Future<Either<ApiError, Unit>> removeFromCart(String productId);
  Future<Either<ApiError, OrderEntity>> placeOrder(List<ProductEntityModel> products);
}
