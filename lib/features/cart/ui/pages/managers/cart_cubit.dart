import 'package:e_commerce_web_app/features/cart/domain/use_cases/get_user_cart_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/app_di.dart';
import '../../../../../core/models/product_entity_model.dart';
import '../../../../../core/utils/async.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial()) {
    init();
  }
  late GetUserCartUseCase _getUserCartUseCase;
  init() {
    _getUserCartUseCase = injector();
  }

  void getUserCart(String userId) async {
    emit(state.reduce(fetchedCartProducts: Async.initial()));
    final result = await _getUserCartUseCase.execute(userId);
    result.fold(
      (l) => emit(
        state.reduce(fetchedCartProducts: Async.failure(l.message ?? "")),
      ),
      (r) => emit(state.reduce(fetchedCartProducts: Async.success(r))),
    );
  }
}
