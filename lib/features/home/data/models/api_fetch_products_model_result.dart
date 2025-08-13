// To parse this JSON data, do
//
//     final apiProductResultModel = apiProductResultModelFromJson(jsonString);

import 'dart:convert';

import '../../../products/data/model/api_get_product_by_id.dart';

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
