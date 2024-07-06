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
    {'name': 'All', 'imagePath': 'images/rice.png'},
    {'name': 'Briyani', 'imagePath': 'images/Briyani.png'},
    {'name': 'Kebab', 'imagePath': 'images/Kebab.png'},
    {'name': 'Briyani', 'imagePath': 'images/Briyani.png'},
  ];

  // Mock data for food items
  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Full chicken',
      'imagePath': 'images/Full Chicken.png',
      'price': 8000.0,
      'description': 'Savor the mouthwatering delight of our Full Chicken, a popular favorite in our restaurant app! Perfectly seasoned and roasted to golden-brown perfection, this dish promises a succulent and flavorful experience with every bite. The Full Chicken is marinated in a blend of aromatic herbs and spices, ensuring a juicy and tender interior, while the crispy, caramelized skin adds an irresistible crunch.',
    },
    {
      'name': 'Shushi Barbecue',
      'imagePath': 'images/Shushi Barbecue.png',
      'price': 5000.0,
      'description': 'Experience a delightful fusion of Japanese tradition and smoky barbecue flavors with our Shushi Barbecue. This unique dish combines the delicate taste of fresh sushi ingredients, such as premium-grade fish, crisp vegetables, and aromatic rice, with the rich, savory essence of barbecue. Perfectly grilled and glazed with a special blend of teriyaki and barbecue sauce, each bite offers a harmonious balance of sweet, tangy, and umami notes. Whether you are a sushi enthusiast or a barbecue lover this dish is sure to tantalize your taste buds and provide an unforgettable culinary adventure.',
    },
    {
      'name': 'Chicken Briyani',
      'imagePath': 'images/Briyani.png',
      'price': 4500.0,
      'description': 'Experience a culinary delight with our Chicken Biryani, a timeless classic that brings the rich flavors of India to your plate. This aromatic dish features tender chicken pieces marinated in a blend of exotic spices, layered with fragrant basmati rice, and cooked to perfection in a sealed pot to retain all its flavors. Each spoonful bursts with a symphony of spices, herbs, and caramelized onions, offering a harmonious balance of savory and aromatic notes. Garnished with fresh cilantro and served with cooling raita and tangy pickle, our Chicken Biryani is a feast for the senses. Whether for a festive celebration or a comforting meal, this biryani promises an unforgettable dining experience.',
    },
  ];

  // Function to handle when a food category is selected
  void onSelectedFoodCategory(String category) {
    debugPrint(category);
    
  }

  // Function to handle when a food is searched
  void onSearchedFood(String food) {
    debugPrint(food);
 
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
