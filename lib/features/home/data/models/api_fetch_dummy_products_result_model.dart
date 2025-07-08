import 'dart:convert';

ApiFetchDummyProductsResultModel apiFetchDummyProductsResultModelFromJson(
  String str,
) => ApiFetchDummyProductsResultModel.fromJson(json.decode(str));

class ApiFetchDummyProductsResultModel {
  final List<ApiProductModel>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ApiFetchDummyProductsResultModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ApiFetchDummyProductsResultModel.fromJson(
    Map<String, dynamic> json,
  ) => ApiFetchDummyProductsResultModel(
    products:
        json["products"] == null
            ? []
            : List<ApiProductModel>.from(
              (json["products"] as List).map(
                (x) => ApiProductModel.fromJson(x),
              ),
            ),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );
}

class ApiProductModel {
  final int? id;
  final String? title;
  final String? description;
  final ApiCategoryEnum? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final ApiDimensionsModel? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final ApiAvailabilityStatusEnum? availabilityStatus;
  final List<ApiReviewModel>? reviews;
  final ApiReturnPolicyEnum? returnPolicy;
  final int? minimumOrderQuantity;
  final ApiMetaModel? meta;
  final List<String>? images;
  final String? thumbnail;

  ApiProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) =>
      ApiProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: categoryValues.map[json["category"]],
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        tags:
            json["tags"] == null
                ? []
                : List<String>.from((json["tags"] as List).map((x) => x)),
        brand: json["brand"],
        sku: json["sku"],
        weight: json["weight"],
        dimensions:
            json["dimensions"] == null
                ? null
                : ApiDimensionsModel.fromJson(json["dimensions"]),
        warrantyInformation: json["warrantyInformation"],
        shippingInformation: json["shippingInformation"],
        availabilityStatus:
            availabilityStatusValues.map[json["availabilityStatus"]],
        reviews:
            json["reviews"] == null
                ? []
                : List<ApiReviewModel>.from(
                  (json["reviews"] as List).map(
                    (x) => ApiReviewModel.fromJson(x),
                  ),
                ),
        returnPolicy: returnPolicyValues.map[json["returnPolicy"]],
        minimumOrderQuantity: json["minimumOrderQuantity"],
        meta: json["meta"] == null ? null : ApiMetaModel.fromJson(json["meta"]),
        images:
            json["images"] == null
                ? []
                : List<String>.from((json["images"] as List).map((x) => x)),
        thumbnail: json["thumbnail"],
      );
}

enum ApiAvailabilityStatusEnum { IN_STOCK, LOW_STOCK }

final availabilityStatusValues = EnumValues({
  "In Stock": ApiAvailabilityStatusEnum.IN_STOCK,
  "Low Stock": ApiAvailabilityStatusEnum.LOW_STOCK,
});

enum ApiCategoryEnum { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

final categoryValues = EnumValues({
  "beauty": ApiCategoryEnum.BEAUTY,
  "fragrances": ApiCategoryEnum.FRAGRANCES,
  "furniture": ApiCategoryEnum.FURNITURE,
  "groceries": ApiCategoryEnum.GROCERIES,
});

class ApiDimensionsModel {
  final double? width;
  final double? height;
  final double? depth;

  ApiDimensionsModel({this.width, this.height, this.depth});

  factory ApiDimensionsModel.fromJson(Map<String, dynamic> json) =>
      ApiDimensionsModel(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
      );
}

class ApiMetaModel {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  ApiMetaModel({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  factory ApiMetaModel.fromJson(Map<String, dynamic> json) => ApiMetaModel(
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    barcode: json["barcode"],
    qrCode: json["qrCode"],
  );
}

enum ApiReturnPolicyEnum {
  NO_RETURN_POLICY,
  THE_30_DAYS_RETURN_POLICY,
  THE_60_DAYS_RETURN_POLICY,
  THE_7_DAYS_RETURN_POLICY,
  THE_90_DAYS_RETURN_POLICY,
}

final returnPolicyValues = EnumValues({
  "No return policy": ApiReturnPolicyEnum.NO_RETURN_POLICY,
  "30 days return policy": ApiReturnPolicyEnum.THE_30_DAYS_RETURN_POLICY,
  "60 days return policy": ApiReturnPolicyEnum.THE_60_DAYS_RETURN_POLICY,
  "7 days return policy": ApiReturnPolicyEnum.THE_7_DAYS_RETURN_POLICY,
  "90 days return policy": ApiReturnPolicyEnum.THE_90_DAYS_RETURN_POLICY,
});

class ApiReviewModel {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ApiReviewModel({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory ApiReviewModel.fromJson(Map<String, dynamic> json) => ApiReviewModel(
    rating: json["rating"],
    comment: json["comment"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    reviewerName: json["reviewerName"],
    reviewerEmail: json["reviewerEmail"],
  );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);
}
