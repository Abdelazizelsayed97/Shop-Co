import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/barnds/domain/entity/brand_entity.dart';

abstract class BrandsRepository {
  Future<Either<ApiError, List<BrandEntity>>> fetchBrands();
}
