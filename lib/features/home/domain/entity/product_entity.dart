class ProductEntity {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  int? rate;

    final String? title;


    final CaegoryEntity? category;
    final List<String>? images;
    final DateTime? creationAt;
    final DateTime? updatedAt;

  ProductEntity({
    this.image,
    this.id,
    this.name,
    this.description,
    this.price,
    this.rate,
    this.title,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });
}
class CaegoryEntity {
    final String? id;
    final String? name;
    final String? image;

    CaegoryEntity({
    this.id,
    this.name,
    this.image,
    });
}

