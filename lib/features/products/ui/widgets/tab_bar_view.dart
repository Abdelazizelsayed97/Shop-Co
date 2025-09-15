import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';
import 'package:e_commerce_web_app/features/products/ui/widgets/reviews_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/text_styles.dart';

class ProductTabBarView extends StatelessWidget {
  const ProductTabBarView({
    super.key,
    required this.tabController,
    required this.description,
    required this.reviews,
  });

  final TabController tabController;
  final String description;
  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Details", icon: Icon(Iconsax.info_circle)),
            Tab(text: "Reviews", icon: Icon(Icons.reviews_outlined)),
          ],
        ),
        SizedBox(
          height: 200.h,
          child: TabBarView(
            controller: tabController,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 12.h,
                ),
                child: Text(
                  description,
                  style: TextStyles.mediumFont(),
                ),
              ),
              ReviewsView(reviews: reviews),
            ],
          ),
        ),
      ],
    );
  }
}
