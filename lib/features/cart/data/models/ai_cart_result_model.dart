// To parse this JSON data, do
//
//     final apiCartItemsResultModel = apiCartItemsResultModelFromJson(jsonString);

import 'dart:convert';

ApiCartItemsResultModel apiCartItemsResultModelFromJson(String str) =>
    ApiCartItemsResultModel.fromJson(json.decode(str));

String apiCartItemsResultModelToJson(ApiCartItemsResultModel data) =>
    json.encode(data.toJson());

class ApiCartItemsResultModel {
  final List<ApiProductItemModel>? products;
  final String? message;

  ApiCartItemsResultModel({this.products, this.message});

  factory ApiCartItemsResultModel.fromJson(Map<String, dynamic> json) =>
      ApiCartItemsResultModel(
        products:
            json["products"] == null
                ? []
                : List<ApiProductItemModel>.from(
                  json["products"]!.map((x) => ApiProductItemModel.fromJson(x)),
                ),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    "message": message,
  };
}

class ApiProductItemModel {
  final String? id;
  final String? productId;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? brand;
  final double? rating;
  final int? stock;
  final int? quantity;

  ApiProductItemModel({
    this.id,
    this.productId,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.brand,
    this.rating,
    this.stock,
    this.quantity,
  });

  factory ApiProductItemModel.fromJson(Map<String, dynamic> json) =>
      ApiProductItemModel(
        id: json["_id"],
        productId: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        imageUrl: json["imageUrl"],
        brand: json["brand"],
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        quantity: json["quantity"],
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
    "quantity": quantity,
  };
}
