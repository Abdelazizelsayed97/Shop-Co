import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';

import '../../../../core/models/product_entity_model.dart';

final List<String> categories = const [
  "Shop",
  "On Sale",
  "New Arrivals",
  "Brands",
];

List<ProductEntityModel> products = [
  ProductEntityModel(
    id: "1",
    name: "T-SHIRT WITH TAPE DETAILS",
    description: "Description 1",
    price: 100.0,
    images: ["lib/assets/images/product-1.png"],
    rating: 4,
    brand: "Adidas",
    stock: 10,
  ),
  ProductEntityModel(
    id: "2",
    name: "SKINNY FIT JEANS",
    description: "Description 2",
    price: 200.0,
    images: ["lib/assets/images/product-2.png"],
    rating: 5,
    brand: "Puma",
    stock: 10,
  ),
  ProductEntityModel(
    id: "3",
    name: "CHECKERED SHIRT",
    description: "Description 3",
    price: 300.0,
    images: ["lib/assets/images/product-3.png"],
    rating: 3,
    brand: "Adidas",
    stock: 10,
  ),
  ProductEntityModel(
    id: "3",
    name: "SLEEVE STRIPED T-SHIRT",
    description: "Description 4",
    price: 300.0,
    images: ["lib/assets/images/product-4.png"],
    rating: 3,
    brand: "Puma",
    stock: 10,
  ),
];
List<ProductEntity> fetchedProducts = [];
List<ProductEntityModel> fetchedpp = [];
List<ReviewEntity> reviews = [
  ReviewEntity(
    id: "1",
    user: UserInfoEntity(fullName: "John Doe"),
    rate: 5,
    description: "This is a review",
  ),
  ReviewEntity(
    id: "2",
    user: UserInfoEntity(fullName: "John Doe"),
    rate: 5,
    description: "This is a review",
  ),
  ReviewEntity(
    id: "3",
    user: UserInfoEntity(fullName: "John Doe"),
    rate: 5,
    description: "This is a review",
  ),
  ReviewEntity(
    id: "4",
    user: UserInfoEntity(fullName: "John Doe"),
    rate: 5,
    description: "This is a review",
  ),
];
