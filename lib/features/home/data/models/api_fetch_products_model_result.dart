// To parse this JSON data, do
//
//     final apiProductResultModel = apiProductResultModelFromJson(jsonString);

import 'dart:convert';

ApiProductResultModel apiProductResultModelFromJson(String str) =>
    ApiProductResultModel.fromJson(json.decode(str));

String apiProductResultModelToJson(ApiProductResultModel data) =>
    json.encode(data.toJson());

class ApiProductResultModel {
  final List<ApiProductModel>? products;
  final int? page;
  final int? limit;
  final bool? hasNext;
  final int? total;
  final String? message;

  ApiProductResultModel({
    this.products,
    this.page,
    this.limit,
    this.hasNext,
    this.total,
    this.message,
  });

  factory ApiProductResultModel.fromJson(Map<String, dynamic> json) =>
      ApiProductResultModel(
        products:
            json["products"] == null
                ? []
                : List<ApiProductModel>.from(
                  json["products"]!.map((x) => ApiProductModel.fromJson(x)),
                ),
        page: json["page"],
        limit: json["limit"],
        hasNext: json["hasNext"],
        total: json["total"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "hasNext": hasNext,
    "total": total,
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
