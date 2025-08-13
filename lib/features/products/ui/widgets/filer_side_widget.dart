import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSidebar extends StatelessWidget {
  const FilterSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("Filters", Icons.filter_alt_outlined),
          _buildSectionList("T-shirts", "Shorts", "Shirts", "Hoodie", "Jeans"),
          Divider(),
          _buildPriceSlider(),
          Divider(),
          _buildColorSection(),
          Divider(),
          _buildSizeSection(),
          Divider(),
          _buildSectionList(
            "Casual",
            "Formal",
            "Party",
            "Gym",
            "any",
            title: "Dress Style",
          ),
          SizedBox(height: 20.h),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, IconData icon) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(icon, size: 20.r),
      ],
    );
  }

  Widget _buildSectionList(
    String a,
    String b,
    String c,
    String d,
    String e, {
    String title = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ...[a, b, c, d, e].map(
          (item) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(item, style: TextStyle(fontSize: 14.sp)),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _expandableHeader("Price"),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.black,
            overlayColor: Colors.black12,
          ),
          child: RangeSlider(
            values: const RangeValues(50, 200),
            min: 0,
            max: 300,
            onChanged: (_) {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$50", style: TextStyle(fontSize: 12.sp)),
            Text("\$200", style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ],
    );
  }

  Widget _buildColorSection() {
    final colors = [
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.orange,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.white,
      Colors.black,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _expandableHeader("Colors"),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              colors.map((color) {
                bool isSelected = color == Colors.blue; // dummy selected
                return Container(
                  width: 30.r,
                  height: 30.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: 2.r,
                    ),
                  ),
                  child:
                      isSelected
                          ? Icon(
                            Icons.check,
                            size: 16.r,
                            color:
                                color == Colors.white
                                    ? Colors.black
                                    : Colors.white,
                          )
                          : null,
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeSection() {
    final sizes = [
      "XX-Small",
      "X-Small",
      "Small",
      "Medium",
      "Large",
      "X-Large",
      "XX-Large",
      "3X-Large",
      "4X-Large",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _expandableHeader("Size"),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              sizes.map((size) {
                bool isSelected = size == "Large"; // dummy selection
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        onPressed: () {},
        child: Text(
          "Apply Filter",
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget _expandableHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.expand_less, size: 20.r),
      ],
    );
  }
}
