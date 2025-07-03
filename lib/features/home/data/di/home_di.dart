import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/features/home/data/repository/home_repository_impl.dart';
import 'package:e_commerce_web_app/features/home/domain/fetch_products_use_case.dart';
import 'package:e_commerce_web_app/features/home/domain/repository/home_repository.dart';
import 'package:e_commerce_web_app/features/home/ui/manager/cubit/home_cubit.dart';

class HomeDi {
  static void init() {
    injector.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
    injector.registerLazySingleton<FetchProductsUseCase>(() => FetchProductsUseCase(homeRepository: injector()));
    injector.registerLazySingleton<HomeCubit>(() => HomeCubit());
    
  }
}