import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class ProductItemBuilder extends StatefulWidget {
  const ProductItemBuilder({super.key, required this.product, this.isLocal});
  final ProductEntityModel product;
  final bool? isLocal;

  @override
  State<ProductItemBuilder> createState() => _ProductItemBuilderState();
}

class _ProductItemBuilderState extends State<ProductItemBuilder> {
  double rating = 0;
  final int starCount = 5;
  @override
  void initState() {
    if (rating == 0) {
      rating = widget.product.rating?.toDouble() ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/products");
        Get.to(() => ProductDetailsPage(products: widget.product));
      },
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              (widget.product.images?[0].isNotEmpty ?? false)
                  ? CachedNetworkImage(
                    fit: BoxFit.scaleDown,

                    imageUrl: widget.product.images?[0] ?? "",
                    // height: getItemHeight(constrains, context),
                    errorWidget: (context, url, error) {
                      return Icon(Iconsax.warning_2, color: Colors.red);
                    },
                  )
                  : Image.asset(widget.product.images?[0] ?? ""),
              16.responsiveHeight(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? "",
                      style: TextStyles.boldFont(fontSize: 14),
                    ),
                    8.responsiveHeight(),
                    Row(
                      children: [
                        Center(
                          child: StarRating(
                            size: 20.r,
                            rating: rating,
                            color: Colors.orange,
                            borderColor: Colors.grey,
                            allowHalfRating: true,
                            starCount: starCount,
                            onRatingChanged:
                                (rating) => setState(() {
                                  this.rating = rating;
                                  widget.product.rating = rating;
                                }),
                          ),
                        ),
                        Text(widget.product.rating.toString()),
                      ],
                    ),
                    8.responsiveHeight(),
                    Text(
                      "${widget.product.price} EGP",
                      style: TextStyles.semiBoldFont(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    8.responsiveHeight(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
