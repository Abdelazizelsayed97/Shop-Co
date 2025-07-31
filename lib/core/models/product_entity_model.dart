import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ProductEntityModel extends Equatable {
  final String? id;
  final String? productId;
  final String? name;
  final String? description;
  final double? price;
  final List<String>? images;
  final String? brand;
  double? rating;
  final int? stock;
  final int? quantity;

  ProductEntityModel({
    this.id,
    this.productId,
    this.name,
    this.description,
    this.price,
    this.images,
    this.brand,
    this.rating,
    this.stock,
    this.quantity,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    name,
    description,
    price,
    images,
    brand,
    rating,
    stock,
    quantity,
  ];
}
