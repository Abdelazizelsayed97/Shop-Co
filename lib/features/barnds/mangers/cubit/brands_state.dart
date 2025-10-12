part of 'brands_cubit.dart';

@freezed
class BrandsState extends Equatable {
  final Async<List<BrandEntity>> brands;

  const BrandsState({required this.brands});
  factory BrandsState.initial() {
    return const BrandsState(brands: Async.initial());
  }
  BrandsState reduce({Async<List<BrandEntity>>? brands}) {
    return BrandsState(brands: brands ?? this.brands);
  }

  @override
  List<Object?> get props => [brands];
}