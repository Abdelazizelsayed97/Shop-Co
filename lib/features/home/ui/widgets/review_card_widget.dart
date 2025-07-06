import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCardWidget extends StatefulWidget {
  const ReviewCardWidget({super.key, required this.review});
  final ReviewEntity review;

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget> {
  double rating = 0;
  int starCount = 5;

  @override
  void initState() {
    if (rating == 0) {
      rating = widget.review.rate?.toDouble() ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * .2,
      padding: EdgeInsets.all(8.0.r),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        widget.review.rate = rating.toInt();
                      }),
                ),
              ),
              Text(
                widget.review.rate.toString(),
                style: TextStyles.regularFont(fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Text(
              widget.review.user?.fullName ?? "",
              style: TextStyles.regularFont(fontSize: 14),
            ),
          ),
          Text(
            widget.review.description ?? "",
            style: TextStyles.regularFont(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
