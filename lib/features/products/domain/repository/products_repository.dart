import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';

import '../../../../core/models/product_entity_model.dart';
import '../../../../core/paginated_data.dart';

abstract class ProductsRepository {
  Future<Either<ApiError, PaginatedData<ProductEntityModel>>> fetchProducts();
  Future<Either<ApiError, ProductEntityModel>> getProductById(String id);
}
