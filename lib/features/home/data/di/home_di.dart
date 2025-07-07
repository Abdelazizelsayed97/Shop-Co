import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/graph_config_with_header.dart';
import 'package:e_commerce_web_app/features/home/data/repository/home_repository_impl.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_product_dummy_use_case.dart';
import 'package:e_commerce_web_app/features/home/domain/use_case/fetch_products_use_case.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';
import 'package:e_commerce_web_app/features/home/ui/manager/cubit/home_cubit.dart';

class HomeDi {
  static void init() {
    injector.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
    injector.registerLazySingleton<FetchProductsUseCase>(
      () => FetchProductsUseCase(homeRepository: injector()),
    );
    injector.registerLazySingleton<HomeCubit>(() => HomeCubit());
    injector.registerLazySingleton<GraphQlConfigWithHeader>(
      () => GraphQlConfigWithHeader(),
    );
    injector.registerLazySingleton<FetchProductDummyUseCase>(
      () => FetchProductDummyUseCase(injector()),
    );
  }
}
