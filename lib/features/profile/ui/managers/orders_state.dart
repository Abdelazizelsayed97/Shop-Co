part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final Async<List<OrderEntity>> orders;

  const OrdersState({required this.orders});

  factory OrdersState.initial() {
    return const OrdersState(orders: Async.initial());
  }

  OrdersState reduce({Async<List<OrderEntity>>? orders}) {
    return OrdersState(orders: orders ?? this.orders);
  }

  @override
  List<Object?> get props => [orders];
}
