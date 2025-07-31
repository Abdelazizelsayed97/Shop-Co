import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';

import '../../../../core/models/product_entity_model.dart';

class FetchProductDummyUseCase {
  final HomeRepository _repository;

  FetchProductDummyUseCase(this._repository);

  Future<Either<ApiError, List<ProductEntityModel>>> call(
    String limit,
    String skip,
  ) {
    return _repository.getProductsByCategory(limit, skip);
  }
}
