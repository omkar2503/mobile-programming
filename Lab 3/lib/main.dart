import 'package:flutter/material.dart';

void main() {
  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ProductListScreen(),
    ProfileScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> carouselImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<Map<String, dynamic>> featuredProducts = [
    {'name': 'Laptop', 'price': '₹98,754', 'image': 'assets/images/laptop.png'},
    {'name': 'Smartphone', 'price': '₹23,650', 'image': 'assets/images/smartphone.png'},
    {'name': 'Headphones', 'price': '₹2,540', 'image': 'assets/images/headphone.png'},
    {'name': 'Smartwatch', 'price': '₹980', 'image': 'assets/images/smartwatch.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel Section
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: carouselImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: AssetImage(carouselImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),

          // Welcome Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Welcome to our E-Commerce App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),

          // Featured Products Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Featured Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),

          // Grid of Featured Products
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                        child: Image.asset(
                          featuredProducts[index]['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featuredProducts[index]['name'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            featuredProducts[index]['price'],
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': '₹98,754', 'image': 'assets/images/laptop.png', 'description': 'High-performance laptop'},
    {'name': 'Smartphone', 'price': '₹23,650', 'image': 'assets/images/smartphone.png', 'description': 'Latest smartphone'},
    {'name': 'Headphones', 'price': '₹2,540', 'image': 'assets/images/headphone.png', 'description': 'Noise-cancelling headphones'},
    {'name': 'Smartwatch', 'price': '₹980', 'image': 'assets/images/smartwatch.png', 'description': 'Fitness tracking smartwatch'},
    {'name': 'Tablet', 'price': '₹42,000', 'image': 'assets/images/tablet.png', 'description': 'Portable and powerful tablet'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Image.asset(products[index]['image']),
            title: Text(products[index]['name']),
            subtitle: Text(products[index]['price']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: products[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product['image']),
            SizedBox(height: 10),
            Text(product['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(product['price'], style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Text(product['description'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            "Omkar Jadhav",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("E-Commerce App User", style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Laptop', 'price': '₹98,754', 'image': 'assets/images/laptop.png'},
    {'name': 'Smartphone', 'price': '₹23,650', 'image': 'assets/images/smartphone.png'},
  ];

  @override
  Widget build(BuildContext context) {
    int totalPrice = 98754 + 23650;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Cart", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(cartItems[index]['image']),
                    title: Text(cartItems[index]['name']),
                    subtitle: Text(cartItems[index]['price']),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("₹$totalPrice", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Placed Successfully!")));
              },
              child: Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }
}