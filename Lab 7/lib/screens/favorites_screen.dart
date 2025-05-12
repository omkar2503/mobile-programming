import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickbite/providers/user_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final favorites = user?.favorites ?? [];

    final List<Map<String, dynamic>> allFoods = [
      {
        'id': '1',
        'name': 'Margherita Pizza',
        'price': '₹499',
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
        'rating': 4.5,
      },
      {
        'id': '2',
        'name': 'Chicken Burger',
        'price': '₹299',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
        'rating': 4.2,
      },
      {
        'id': '3',
        'name': 'Sushi Platter',
        'price': '₹999',
        'image': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
        'rating': 4.8,
      },
      {
        'id': '4',
        'name': 'Pasta Carbonara',
        'price': '₹599',
        'image': 'https://images.unsplash.com/photo-1473093226795-af9932fe5856',
        'rating': 4.3,
      },
    ];

    final favoriteFoods = allFoods.where((food) => favorites.contains(food['id'])).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: favoriteFoods.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'No favorites yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Add your favorite foods here',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: favoriteFoods.length,
              itemBuilder: (context, index) {
                final food = favoriteFoods[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15.r),
                        ),
                        child: Image.network(
                          food['image'],
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    food['rating'].toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                food['price'],
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<UserProvider>().removeFromFavorites(food['id']);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30.sp,
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