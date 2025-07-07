part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Async<List<ProductEntity>> products;
  final Async<List<DummyProductEntity>> dummyProducts;
  factory HomeState.init() {
    return HomeState(products: Async.initial(), dummyProducts: Async.initial());
  }
  const HomeState({required this.products, required this.dummyProducts});

  HomeState reduce({
    Async<List<ProductEntity>>? products,
    Async<List<DummyProductEntity>>? dummyProducts,
  }) {
    return HomeState(
      products: products ?? this.products,
      dummyProducts: dummyProducts ?? this.dummyProducts,
    );
  }

  @override
  List<Object?> get props => [products, dummyProducts];
}
