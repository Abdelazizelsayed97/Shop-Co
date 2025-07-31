part of "product_cubit.dart";

class ProductState extends Equatable {
  final Async<List<ProductEntityModel>> fetchProducts;

  const ProductState({required this.fetchProducts});
  factory ProductState.initial() {
    return ProductState(fetchProducts: Async.initial());
  }
  ProductState reduce({Async<List<ProductEntityModel>>? fetchProducts}) {
    return ProductState(fetchProducts: fetchProducts ?? this.fetchProducts);
  }

  @override
  List<Object?> get props => [fetchProducts];
}
