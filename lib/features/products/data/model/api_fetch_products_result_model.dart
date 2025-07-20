// To parse this JSON data, do
//
//     final apiShopCoResultModel = apiShopCoResultModelFromJson(jsonString);

import 'dart:convert';

ApiShopCoResultModel apiShopCoResultModelFromJson(String str) =>
    ApiShopCoResultModel.fromJson(json.decode(str));

String apiShopCoResultModelToJson(ApiShopCoResultModel data) =>
    json.encode(data.toJson());

class ApiShopCoResultModel {
  final List<ApiProductsModel>? products;
  final int? page;
  final int? limit;
  final String? message;

  ApiShopCoResultModel({this.message, this.products, this.page, this.limit});

  factory ApiShopCoResultModel.fromJson(Map<String, dynamic> json) =>
      ApiShopCoResultModel(
        products:
            json["products"] == null
                ? []
                : List<ApiProductsModel>.from(
                  json["products"]!.map((x) => ApiProductsModel.fromJson(x)),
                ),
        page: json["page"],
        limit: json["limit"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "message": message,
  };
}

class ApiProductsModel {
  final String? id;
  final String? productId;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? brand;
  final double? rating;
  final int? stock;

  ApiProductsModel({
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

  factory ApiProductsModel.fromJson(Map<String, dynamic> json) =>
      ApiProductsModel(
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
