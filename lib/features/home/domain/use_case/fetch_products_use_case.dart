import 'package:dartz/dartz.dart';
import 'package:e_commerce_web_app/core/helper/api_error_handler.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';

class FetchProductsUseCase {
  final HomeRepository homeRepository;
  FetchProductsUseCase({required this.homeRepository});
  Future<Either<ApiError, List<ProductEntity>>> call() async {
    return await homeRepository.getProducts();
  }
}
