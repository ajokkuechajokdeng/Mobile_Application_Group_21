import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/food_categories.dart';
import 'package:SpeedyServe/components/food_item.dart';
import 'package:SpeedyServe/components/promotion_card.dart';
import 'package:SpeedyServe/components/search_bar.dart';
import 'package:SpeedyServe/screens/app_screens/profile_screen.dart';
import 'package:SpeedyServe/screens/app_screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeedyServe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for food categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Category 1', 'imagePath': 'assets/category1.jpg'},
    {'name': 'Category 2', 'imagePath': 'assets/category2.jpg'},
    {'name': 'Category 3', 'imagePath': 'assets/category3.jpg'},
  ];

  // Mock data for food items
  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Full chicken',
      'imagePath': 'assets/images/chickenn.jpeg',
      'price': 8000.0,
      'description': 'Description for Food 1',
    },
    {
      'name': 'Food 2',
      'imagePath': 'assets/images/Shushi Barbecue.jpg',
      'price': 5000.0,
      'description': 'Description for Food 2',
    },
    {
      'name': 'Food 3',
      'imagePath': 'assets/food3.jpg',
      'price': 4500.0,
      'description': 'Description for Food 3',
    },
  ];

  // Function to handle when a food category is selected
  void onSelectedFoodCategory(String category) {
    debugPrint(category);
    // Implement your logic here
  }

  // Function to handle when a food is searched
  void onSearchedFood(String food) {
    debugPrint(food);
    // Implement your logic here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications, size: 25.0),
                      onPressed: () {
                        // Implement notification action
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Search bar
                SearchField(
                  onSearchedFood: onSearchedFood,
                ),
                const SizedBox(height: 20),
                // Food categories (Scrollable horizontally)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FoodCategory(
                            imagePath: category['imagePath'],
                            name: category['name'],
                            onTap: () {
                              onSelectedFoodCategory(category['name']);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Promotions
                const PromotionCard(),
                const SizedBox(height: 20),
                // Popular items
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: foods.map((food) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: FoodProduct(
                              name: food['name'],
                              imagePath: food['imagePath'],
                              price: food['price'],
                              description: food['description'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
         selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // Handle navigation based on selected index
            switch (index) {
              case 0:
                debugPrint('Home selected');
                break;
              case 1:
                debugPrint('Search selected');
                break;
              case 2:
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
                break;
              case 3:
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
