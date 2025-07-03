// To parse this JSON data, do
//
//     final apiFetchProductsResultModel = apiFetchProductsResultModelFromJson(jsonString);

import 'dart:convert';

ApiFetchProductsResultModel apiFetchProductsResultModelFromJson(String str) =>
    ApiFetchProductsResultModel.fromJson(json.decode(str));

String apiFetchProductsResultModelToJson(ApiFetchProductsResultModel data) =>
    json.encode(data.toJson());

class ApiFetchProductsResultModel {
  final List<Product>? products;

  ApiFetchProductsResultModel({this.products});

  factory ApiFetchProductsResultModel.fromJson(Map<String, dynamic> json) =>
      ApiFetchProductsResultModel(
        products:
            json["products"] == null
                ? []
                : List<Product>.from(
                  json["products"]!.map((x) => Product.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  final String? id;
  final String? title;
  final int? price;
  final String? description;
  final Category? category;
  final List<String>? images;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    images:
        json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
    creationAt:
        json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Category {
  final String? id;
  final Name? name;
  final String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "image": image,
  };
}

enum Name { CLOTHES, ELECTRONICS, FURNITURE, GROSERY, MISCELLANEOUS, SHOES }

final nameValues = EnumValues({
  "Clothes": Name.CLOTHES,
  "Electronics": Name.ELECTRONICS,
  "Furniture": Name.FURNITURE,
  "Grosery": Name.GROSERY,
  "Miscellaneous": Name.MISCELLANEOUS,
  "Shoes": Name.SHOES,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
