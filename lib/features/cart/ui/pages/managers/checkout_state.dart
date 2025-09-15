part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final Async<OrderEntity> placeOrder;

  const CheckoutState({required this.placeOrder});

  factory CheckoutState.initial() {
    return const CheckoutState(placeOrder: Async.initial());
  }

  CheckoutState reduce({Async<OrderEntity>? placeOrder}) {
    return CheckoutState(placeOrder: placeOrder ?? this.placeOrder);
  }

  @override
  List<Object?> get props => [placeOrder];
}
