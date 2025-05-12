import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickbite/providers/user_provider.dart';

class PopularFoodList extends StatelessWidget {
  const PopularFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> popularFoods = [
      {
        'id': '1',
        'name': 'Margherita Pizza',
        'price': 499,
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
        'rating': 4.5,
      },
      {
        'id': '2',
        'name': 'Chicken Burger',
        'price': 299,
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
        'rating': 4.2,
      },
      {
        'id': '3',
        'name': 'Sushi Platter',
        'price': 999,
        'image': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
        'rating': 4.8,
      },
      {
        'id': '4',
        'name': 'Pasta Carbonara',
        'price': 599,
        'image': 'https://images.unsplash.com/photo-1473093226795-af9932fe5856',
        'rating': 4.3,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 30.w,
        mainAxisSpacing: 30.h,
        childAspectRatio: 0.8,
      ),
      itemCount: popularFoods.length,
      itemBuilder: (context, index) {
        final food = popularFoods[index];
        final userProvider = context.watch<UserProvider>();
        final isFavorite = userProvider.user?.favorites.contains(food['id']) ?? false;
        final cartQuantity = userProvider.user?.cart[food['id']] ?? 0;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    child: Image.network(
                      food['image'],
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10.w,
                    right: 10.w,
                    child: IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          userProvider.removeFromFavorites(food['id']);
                        } else {
                          userProvider.addToFavorites(food['id']);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 24.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          food['rating'].toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${food['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        if (cartQuantity > 0)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  userProvider.updateCartItem(
                                    food['id'],
                                    cartQuantity - 1,
                                  );
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.orange,
                                  size: 24.sp,
                                ),
                              ),
                              Text(
                                cartQuantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  userProvider.updateCartItem(
                                    food['id'],
                                    cartQuantity + 1,
                                  );
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.orange,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          )
                        else
                          ElevatedButton(
                            onPressed: () async {
                              await userProvider.addToCart(food['id'], 1);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${food['name']} added to cart'),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 