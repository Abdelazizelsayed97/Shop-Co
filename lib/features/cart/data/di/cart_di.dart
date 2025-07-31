import 'package:e_commerce_web_app/core/di/app_di.dart';

import '../../domain/repository/cart_repository.dart';
import '../../domain/use_cases/get_user_cart_use_case.dart';
import '../../ui/pages/managers/cart_cubit.dart';
import '../repository/cart_repository_impl.dart';

class CartDi {
  CartDi._();
  static final instance = CartDi._();
  void init() {
    injector.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());
    injector.registerLazySingleton<GetUserCartUseCase>(
      () => GetUserCartUseCase(injector()),
    );
    injector.registerFactory<CartCubit>(() => CartCubit());
  }
}
