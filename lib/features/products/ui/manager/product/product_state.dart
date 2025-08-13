part of "product_cubit.dart";

class ProductState extends Equatable {
  final Async<List<ProductEntityModel>> fetchProducts;
  final Async<ProductEntityModel> productDetails;

  const ProductState({
    required this.fetchProducts,
    required this.productDetails,
  });
  factory ProductState.initial() {
    return ProductState(
      fetchProducts: Async.initial(),
      productDetails: Async.initial(),
    );
  }
  ProductState reduce({
    Async<List<ProductEntityModel>>? fetchProducts,
    Async<ProductEntityModel>? productDetails,
  }) {
    return ProductState(
      fetchProducts: fetchProducts ?? this.fetchProducts,
      productDetails: productDetails ?? this.productDetails,
    );
  }

  @override
  List<Object?> get props => [fetchProducts, productDetails];
}
