import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/features/products/data/repository/products_repository.dart';
import 'package:e_commerce_web_app/features/products/domain/use_cases/fetch_product_user_case.dart';

import '../../domain/repository/products_repository.dart';
import '../../domain/use_cases/product_details_use_case.dart';

class ProductDi {
  void init() {
    injector.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(),
    );
    injector.registerLazySingleton<FetchProductsUserCase>(
      () => FetchProductsUserCase(),
    );
    injector.registerLazySingleton<ProductDetailsUseCase>(
      () => ProductDetailsUseCase(injector()),
    );
  }
}
