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
                  // height: getItemHeight(constrains, context),
                  errorWidget: (context, url, error) {
                    return Icon(Iconsax.warning_2, color: Colors.red);
                  },
                )
                : Image.asset(widget.product.image ?? ""),
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

double getItemHeight(BoxConstraints constraints, BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight =
      constraints.maxWidth > 850
          ? mediaQuery.size.width
          : mediaQuery.size.height;

  // Adjusting for safe areas or app bars if needed
  final usableHeight = screenHeight - mediaQuery.padding.top - kToolbarHeight;

  // You can customize this logic
  if (constraints.maxWidth >= 1200) {
    return usableHeight * 0.36; // desktop layout
  } else if (constraints.maxWidth >= 800) {
    return usableHeight * 0.25; // tablet layout
  } else {
    return usableHeight * 0.35; // mobile layout
  }
}
