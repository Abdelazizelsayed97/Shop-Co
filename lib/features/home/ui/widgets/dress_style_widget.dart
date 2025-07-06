import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DressStyleWidget extends StatelessWidget {
  DressStyleWidget({super.key});
  final List<String> dressStyles = [
    "lib/assets/images/casual-fram.png",
    "lib/assets/images/formal-frame.png",
    "lib/assets/images/party-frame.png",
    "lib/assets/images/gym-frame.png",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 60.h),
          child: Column(
            children: [
              Text(
                "BROWSE BY dress STYLE",
                style: TextStyles.boldFont(fontSize: 48.sp),
              ),
              64.responsiveHeight(),
              constraints.maxWidth > 850
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: StaggeredGrid.count(
                      axisDirection: AxisDirection.down,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      crossAxisCount: 2,
                      children: [
                        StaggeredGridTile.fit(
                          crossAxisCellCount: 1,

                          child: Image.asset(dressStyles[0]),
                        ),
                        StaggeredGridTile.fit(
                          crossAxisCellCount: 1,

                          child: Image.asset(dressStyles[1]),
                        ),

                        StaggeredGridTile.fit(
                          crossAxisCellCount: 1,

                          child: Image.asset(dressStyles[3]),
                        ),
                        StaggeredGridTile.fit(
                          crossAxisCellCount: 1,

                          child: Image.asset(dressStyles[2]),
                        ),
                      ],
                    ),
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      dressStyles.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: AlwaysStoppedAnimation<double>(1),
                              curve: Interval(
                                0.1 * index,
                                1,
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                          child: Image.asset(
                            dressStyles[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}

// str() {
//   return Wrap(
//     alignment: WrapAlignment.start,
//     direction: Axis.horizontal,
//     crossAxisAlignment: WrapCrossAlignment.start,
//     runAlignment: WrapAlignment.center,
//     children: List.generate(
//       dressStyles.length,
//       (index) => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//         child: ScaleTransition(
//           scale: Tween<double>(begin: 0, end: 1).animate(
//             CurvedAnimation(
//               parent: AlwaysStoppedAnimation<double>(1),
//               curve: Interval(0.1 * index, 1, curve: Curves.easeInOut),
//             ),
//           ),
//           child: Image.asset(dressStyles[index], fit: BoxFit.cover),
//         ),
//       ),
//     ),
//   );
// }
