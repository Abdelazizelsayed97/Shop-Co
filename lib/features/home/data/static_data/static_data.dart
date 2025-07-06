import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';

final List<String> categories = const [
    "Shop",
    "On Sale",
    "New Arrivals",
    "Brands",
  ];

  List<ProductEntity> products = [
    ProductEntity(
      id: "1",
      name: "T-SHIRT WITH TAPE DETAILS",
      description: "Description 1",
      price: 100.0,
      image: "lib/assets/images/product-1.png",
      rate: 4,
    ),
    ProductEntity(
      id: "2",
      name: "SKINNY FIT JEANS",
      description: "Description 2",
      price: 200.0,
      image: "lib/assets/images/product-2.png",
      rate: 5,
    ),
    ProductEntity(
      id: "3",
      name: "CHECKERED SHIRT",
      description: "Description 3",
      price: 300.0,
      image: "lib/assets/images/product-3.png",
      rate: 3,
    ),
    ProductEntity(
      id: "3",
      name: "SLEEVE STRIPED T-SHIRT",
      description: "Description 4",
      price: 300.0,
      image: "lib/assets/images/product-4.png",
      rate: 3,
    ),
  ];
   List<ProductEntity> fetchedProducts = [];
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
