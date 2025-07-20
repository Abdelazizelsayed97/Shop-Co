import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';

import '../../../../core/paginated_data.dart';
import '../entity/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<ApiError, PaginatedData<ProductsEntity>>> fetchProducts();
}
