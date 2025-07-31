part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Async<List<ProductEntityModel>> fetchedCartProducts;

  const CartState({required this.fetchedCartProducts});
  factory CartState.initial() {
    return const CartState(fetchedCartProducts: Async.initial());
  }
  CartState reduce({Async<List<ProductEntityModel>>? fetchedCartProducts}) {
    return CartState(
      fetchedCartProducts: fetchedCartProducts ?? this.fetchedCartProducts,
    );
  }

  @override
  List<Object?> get props => [fetchedCartProducts];
}
