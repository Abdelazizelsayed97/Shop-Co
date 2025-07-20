import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final String? id;
  final String? productId;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? brand;
  final double? rating;
  final int? stock;

  const ProductsEntity({
    this.id,
    this.productId,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.brand,
    this.rating,
    this.stock,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    name,
    description,
    price,
    imageUrl,
    brand,
    rating,
    stock,
  ];
}
