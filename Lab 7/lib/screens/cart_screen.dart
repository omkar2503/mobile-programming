import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickbite/providers/user_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final cart = user?.cart ?? {};

    final List<Map<String, dynamic>> allFoods = [
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

    final cartItems = allFoods.where((food) => cart.containsKey(food['id'])).toList();
    final total = cartItems.fold<int>(0, (sum, item) => sum + ((item['price'] as int) * cart[item['id']]!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Add some delicious food to your cart',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.w),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final food = cartItems[index];
                      final quantity = cart[food['id']]!;
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
                                    Text(
                                      '₹${food['price']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<UserProvider>().updateCartItem(
                                                  food['id'],
                                                  quantity - 1,
                                                );
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.orange,
                                            size: 24.sp,
                                          ),
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context.read<UserProvider>().updateCartItem(
                                                  food['id'],
                                                  quantity + 1,
                                                );
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.orange,
                                            size: 24.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '₹$total',
                            style: GoogleFonts.poppins(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement checkout
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checkout functionality coming soon!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 15.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
} 