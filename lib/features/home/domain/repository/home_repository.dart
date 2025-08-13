import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';

import '../../../../core/models/product_entity_model.dart';

abstract class HomeRepository {
  Future<Either<ApiError, List<ProductEntityModel>>> getProductsByCategory(
    String limit,
    String skip,
  );
}
