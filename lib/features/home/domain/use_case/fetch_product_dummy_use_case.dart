import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_product_entity.dart';

import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';

class FetchProductDummyUseCase {
  final HomeRepository _repository;

  FetchProductDummyUseCase(this._repository);

  Future<Either<ApiError, List<DummyProductEntity>>> call(
    String limit,
    String skip,
  ) {
    return _repository.getProductsByCategory(limit, skip);
  }
}
