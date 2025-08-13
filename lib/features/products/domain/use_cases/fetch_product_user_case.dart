import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/paginated_data.dart';
import 'package:e_commerce_web_app/features/products/domain/repository/products_repository.dart';

class FetchProductsUserCase {
  late ProductsRepository _productsRepository;

  FetchProductsUserCase() {
    _productsRepository = injector();
  }
  Future<Either<ApiError, PaginatedData<ProductEntityModel>>> execute() {
    return _productsRepository.fetchProducts();
  }
}
