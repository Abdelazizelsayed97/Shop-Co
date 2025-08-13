import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/features/products/domain/repository/products_repository.dart';

class ProductDetailsUseCase {
  final ProductsRepository _homeRepository;
  const ProductDetailsUseCase(this._homeRepository);
  Future<Either<ApiError, ProductEntityModel>> execute(String id) async {
    return _homeRepository.getProductById(id);
  }
}
