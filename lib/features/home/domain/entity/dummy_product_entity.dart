import 'package:e_commerce_web_app/features/home/domain/entity/dimensions_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/dummy_review_entity.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/meta_data_entity.dart';
import 'package:equatable/equatable.dart';

class DummyProductEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final CategoryEnum? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final DimensionsEntity? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final AvailabilityStatusEnum? availabilityStatus;
  final List<DummyReviewEntity>? reviews;
  final ReturnPolicyEnum? returnPolicy;
  final int? minimumOrderQuantity;
  final MetaDataEntity? meta;
  final List<String>? images;
  final String? thumbnail;

  const DummyProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    sku,
    weight,
    dimensions,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    reviews,
    returnPolicy,
    minimumOrderQuantity,
    meta,
  ];
}

enum CategoryEnum { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

enum AvailabilityStatusEnum { IN_STOCK, LOW_STOCK }

enum ReturnPolicyEnum {
  NO_RETURN_POLICY,
  THE_30_DAYS_RETURN_POLICY,
  THE_60_DAYS_RETURN_POLICY,
  THE_7_DAYS_RETURN_POLICY,
  THE_90_DAYS_RETURN_POLICY,
}
