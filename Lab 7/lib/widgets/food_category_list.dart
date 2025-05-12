import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCategoryList extends StatelessWidget {
  const FoodCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.local_pizza, 'name': 'Pizza'},
      {'icon': Icons.rice_bowl, 'name': 'Rice'},
      {'icon': Icons.lunch_dining, 'name': 'Lunch'},
      {'icon': Icons.local_drink, 'name': 'Drinks'},
      {'icon': Icons.cake, 'name': 'Dessert'},
      {'icon': Icons.fastfood, 'name': 'Fast Food'},
    ];

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: Column(
              children: [
                Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(60.r),
                  ),
                  child: Icon(
                    categories[index]['icon'],
                    color: Colors.orange,
                    size: 50.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  categories[index]['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 