import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/async.dart';
import 'package:e_commerce_web_app/features/profile/domain/entity/order_entity.dart';
import 'package:e_commerce_web_app/features/profile/domain/use_cases/get_orders_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState.initial());

  late GetOrdersUseCase _getOrdersUseCase;

  void init() {
    _getOrdersUseCase = injector();
  }

  void getOrders() async {
    emit(state.reduce(orders: Async.loading()));
    final result = await _getOrdersUseCase.execute();
    result.fold(
      (l) => emit(state.reduce(orders: Async.failure(l.message ?? ''))),
      (r) => emit(state.reduce(orders: Async.success(r))),
    );
  }
}
