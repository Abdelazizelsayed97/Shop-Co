import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/cart/domain/use_cases/place_order_use_case.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutState.initial());

  late PlaceOrderUseCase _placeOrderUseCase;

  void init() {
    _placeOrderUseCase = injector();
  }

  void placeOrder(List<ProductEntityModel> products) async {
    emit(state.reduce(placeOrder: Async.loading()));
    final result = await _placeOrderUseCase.execute(products);
    result.fold(
      (l) => emit(state.reduce(placeOrder: Async.failure(l.message ?? ''))),
      (r) => emit(state.reduce(placeOrder: Async.success(r))),
    );
  }
}
