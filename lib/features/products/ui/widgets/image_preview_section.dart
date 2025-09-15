import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ImagePreviewSection extends StatelessWidget {
  const ImagePreviewSection({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: List.generate(images.length, (
              index,
            ) {
              final image = images[index];
              final isNetwork = image.contains("http");

              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: index == 0 ? 2 : 1,
                  ),
                  // borderRadius: BorderRadius.circular(8.r),
                ),
                child: isNetwork
                    ? CachedNetworkImage(
                        height: 80.h,
                        width: 80.w,
                        fit: BoxFit.fitHeight,
                        imageUrl: image,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Iconsax.warning_2,
                              color: Colors.black,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        image,
                        height: 80.h,
                        fit: BoxFit.fitHeight,
                      ),
              );
            }),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .01),
          Expanded(
            child: (images.isNotEmpty)
                ? CachedNetworkImage(
                    imageUrl: images.first,
                    // height: 300.h,
                    width: MediaQuery.of(context).size.width * .15,
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.grey.shade200,
                        height: 400.h,
                        width: 300.w,
                        child: Icon(Iconsax.warning_2, color: Colors.black),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
