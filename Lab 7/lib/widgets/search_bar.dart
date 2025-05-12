import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for food...',
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 20.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 30.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 25.h,
          ),
        ),
      ),
    );
  }
} 