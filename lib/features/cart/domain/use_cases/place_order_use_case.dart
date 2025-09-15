import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/cart/domain/repository/cart_repository.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';

class PlaceOrderUseCase {
  final CartRepository _cartRepository;

  PlaceOrderUseCase(this._cartRepository);

  Future<Either<ApiError, OrderEntity>> execute(List<ProductEntityModel> products) {
    return _cartRepository.placeOrder(products);
  }
}
