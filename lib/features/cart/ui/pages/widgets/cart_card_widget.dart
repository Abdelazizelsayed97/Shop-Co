import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_web_app/core/models/product_entity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({super.key, required this.product});
  final ProductEntityModel product;

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.images?.first ?? "",
                fit: BoxFit.contain,
                alignment: Alignment.center,
                height: 200.h,
                width: 200.w,
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey_700.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    height: 200.h,
                    width: 200.w,
                    child: Icon(Iconsax.warning_2, size: 24.dm),
                  );
                },
              ),
              SizedBox(width: 24.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.product.name ?? "",
                    style: TextStyles.boldFont(fontSize: 20.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    widget.product.description ?? "",
                    style: TextStyles.regularFont(color: Colors.grey.shade500),
                  ),
                  Text(
                    widget.product.brand ?? "",
                    style: TextStyles.regularFont(color: Colors.grey.shade500),
                  ),
                  Text(
                    widget.product.price.toString(),
                    style: TextStyles.boldFont(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 100.h,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline, size: 24.r, color: Colors.red),
              ),
              PlusMinusWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class PlusMinusWidget extends StatefulWidget {
  const PlusMinusWidget({super.key});

  @override
  State<PlusMinusWidget> createState() => _PlusMinusWidgetState();
}

class _PlusMinusWidgetState extends State<PlusMinusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Iconsax.minus)),
          Text("1"),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
