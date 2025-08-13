// To parse this JSON data, do
//
//     final apiGetProductByIdResultModel = apiGetProductByIdResultModelFromJson(jsonString);

import 'dart:convert';

ApiGetProductByIdResultModel apiGetProductByIdResultModelFromJson(String str) =>
    ApiGetProductByIdResultModel.fromJson(json.decode(str));

String apiGetProductByIdResultModelToJson(ApiGetProductByIdResultModel data) =>
    json.encode(data.toJson());

class ApiGetProductByIdResultModel {
  final ApiProductModel? product;
  final String? message;

  ApiGetProductByIdResultModel({this.product, this.message});

  factory ApiGetProductByIdResultModel.fromJson(Map<String, dynamic> json) =>
      ApiGetProductByIdResultModel(
        product:
            json["product"] == null
                ? null
                : ApiProductModel.fromJson(json["product"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "message": message,
  };
}

class ApiProductModel {
  final String? id;
  final String? productId;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? brand;
  final double? rating;
  final int? stock;

  ApiProductModel({
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

  factory ApiProductModel.fromJson(Map<String, dynamic> json) =>
      ApiProductModel(
        id: json["_id"],
        productId: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        imageUrl: json["imageUrl"],
        brand: json["brand"],
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": productId,
    "name": name,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "brand": brand,
    "rating": rating,
    "stock": stock,
  };
}
