part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Async<List<ProductEntityModel>> fetchedCartProducts;
  final Async<ProductEntityModel> addToCart;

  const CartState({
    required this.fetchedCartProducts,
    required this.addToCart,
  });
  factory CartState.initial() {
    return const CartState(
      fetchedCartProducts: Async.initial(),
      addToCart: Async.initial(),
    );
  }
  CartState reduce({
    Async<List<ProductEntityModel>>? fetchedCartProducts,
    Async<ProductEntityModel>? addToCart,
  }) {
    return CartState(
      fetchedCartProducts: fetchedCartProducts ?? this.fetchedCartProducts,
      addToCart: addToCart ?? this.addToCart,
    );
  }

  @override
  List<Object?> get props => [fetchedCartProducts, addToCart];
}
