import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/cart/domain/repository/cart_repository.dart';

import '../../../../core/helper/api_error_handler.dart';

class GetUserCartUseCase {
  final CartRepository _cartRepository;
  GetUserCartUseCase(this._cartRepository);
  Future<Either<ApiError, List<ProductEntityModel>>> execute(String userId) =>
      _cartRepository.fetchCart(userId);
}
