import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive_by_media_query.dart';
import '../../../../core/utils/text_styles.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.constraints,
    required this.globalKey,
  });
  final BoxConstraints constraints;
  final GlobalKey<ScaffoldState> globalKey;
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h + 40.h);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late TextEditingController _searchController;

  final List<String> _categories = const [
    "Shop",
    "On Sale",
    "New Arrivals",
    "Brands",
  ];
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: widget.constraints.maxWidth > 950 ? 0 : 40.w,
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.constraints.maxWidth > 950 ? 400.w : 0,
          // vertical: 24.h,
        ),
        width:
            widget.constraints.maxWidth > 950
                ? widget.constraints.maxWidth * 0.75
                : widget.constraints.maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildAppBar,
        ),
      ),
      leading:
          widget.constraints.maxWidth > 950
              ? SizedBox.shrink()
              : IconButton(
                onPressed: () => widget.globalKey.currentState?.openDrawer(),
                icon: const Icon(Icons.menu),
              ),
      toolbarHeight: 96.h,
      backgroundColor: Colors.white,
      actions: _buildAppBar,
      actionsPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
    );
  }

  List<Widget> get _buildAppBar {
    return [
      Image.asset("lib/assets/images/logo.png", height: 24.h),
      verticalSpacer(20),
      if (MediaQuery.of(context).size.width > 850) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Wrap(
            children: List.generate(
              _categories.length,
              (index) => MouseRegion(
                onEnter: (event) {
                  if (index == 0) {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
                      useRootNavigator: true,

                      items: [
                        PopupMenuItem(child: Text("Shop")),
                        PopupMenuItem(child: Text("On Sale")),
                        PopupMenuItem(child: Text("New Arrivals")),
                        PopupMenuItem(child: Text("Brands")),
                      ],
                    );
                  }
                },
                onExit: (event) {
                  if (index == 0) {
                    Navigator.pop(context);
                  }
                },
                opaque: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    _categories[index],
                    style: TextStyles.mediumFont(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: AppTextFormField(
            controller: _searchController,
            validator: (value) {},
            onChanged: (value) {},
            label: "Search",
            suffixIcon: Icon(Icons.search, color: Colors.grey.shade300),
            // height: 56.h,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Icon(Icons.shopping_cart),
        ),
      ] else ...[
        Spacer(flex: 1),
        16.responsiveWidth(),
        Icon(Icons.search),
        24.responsiveWidth(),
        Icon(Icons.shopping_cart),
      ],
    ];
  }
}
