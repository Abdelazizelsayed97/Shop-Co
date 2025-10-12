import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';

import 'package:e_commerce_web_app/features/cart/domain/repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  Future<Either<ApiError, void>> execute(String productId) {
    return _cartRepository.addToCart(productId);
  }
}
