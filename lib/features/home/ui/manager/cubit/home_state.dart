part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Async<   List<ProductEntity>> products;
  factory HomeState.init() {
    return HomeState(products: Async.initial());
  }
  const HomeState({required this.products});

  HomeState reduce({Async<List<ProductEntity>>? products}) {
    return HomeState(products: products ?? this.products);
  }

  @override
  List<Object?> get props => [products];
}
