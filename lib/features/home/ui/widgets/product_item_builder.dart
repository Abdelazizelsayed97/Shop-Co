import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProductItemBuilder extends StatefulWidget {
  const ProductItemBuilder({super.key, required this.product});
  final ProductEntity product;

  @override
  State<ProductItemBuilder> createState() => _ProductItemBuilderState();
}

class _ProductItemBuilderState extends State<ProductItemBuilder> {
  double rating = 0;
  final int starCount = 5;
  @override
  void initState() {
    if (rating == 0) {
      rating = widget.product.rate?.toDouble() ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product.images?[0].isNotEmpty ?? false
                ? CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: widget.product.images?[0] ?? "",
                  height: constrains.maxHeight > 850 ? 298.h : 200.h,
                  errorWidget: (context, url, error) {
                    return Icon(Iconsax.warning_2, color: Colors.red);
                  },

                  width: constrains.maxHeight > 950 ? 295.w : 198.w,
                )
                : Image.asset(
                  widget.product.image ?? "",

                  // height: constrains.maxHeight > 850 ? 298.h : 200.h,

                  // width: constrains.maxHeight > 950 ? 295.w : 198.w,
                ),
            16.responsiveHeight(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? widget.product.title ?? "",
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
                                widget.product.rate = rating.toInt();
                              }),
                        ),
                      ),
                      Text(widget.product.rate.toString()),
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
    );
  }
}
