part of 'sale_cubit.dart';

class SaleState extends Equatable {
  final Async<PaginatedData<ProductEntityModel>> products;

  const SaleState({required this.products});
  factory SaleState.initial() {
    return const SaleState(products: Async.initial());
  }
  SaleState reduce({Async<PaginatedData<ProductEntityModel>>? products}) {
    return SaleState(products: products ?? this.products);
  }

  @override
  List<Object?> get props => [products];
}
