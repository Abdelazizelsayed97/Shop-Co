import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/barnds/domain/brands_repository.dart';
import 'package:e_commerce_web_app/features/barnds/domain/entity/brand_entity.dart';

class FetchBrandsUseCase {
  final BrandsRepository _brandsRepository;

  FetchBrandsUseCase(this._brandsRepository);

  Future<Either<ApiError, List<BrandEntity>>> execute() {
    return _brandsRepository.fetchBrands();
  }
}
