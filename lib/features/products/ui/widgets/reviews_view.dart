import 'package:e_commerce_web_app/features/home/domain/entity/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key, required this.reviews});
  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(review.user?.firstName?[0] ?? 'A'),
                    ),
                    const SizedBox(width: 8.0),
                    Text(review.user?.fullName ?? 'Anonymous'),
                  ],
                ),
                const SizedBox(height: 8.0),
                StarRating(
                  rating: review.rate?.toDouble() ?? 0,
                  color: Colors.orange,
                ),
                const SizedBox(height: 8.0),
                Text(review.description ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
