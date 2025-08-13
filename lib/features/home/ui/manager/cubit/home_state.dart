part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Async<List<ProductEntityModel>> dummyProducts;
  factory HomeState.init() {
    return HomeState(dummyProducts: Async.initial());
  }
  const HomeState({required this.dummyProducts});

  HomeState reduce({
    Async<List<ProductEntity>>? products,
    Async<List<ProductEntityModel>>? dummyProducts,
  }) {
    return HomeState(dummyProducts: dummyProducts ?? this.dummyProducts);
  }

  @override
  List<Object?> get props => [dummyProducts];
}
