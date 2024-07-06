import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/cart_item.dart';
import 'package:SpeedyServe/screens/app_screens/profile_screen.dart';
import 'package:SpeedyServe/screens/app_screens/home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _instructionsController = TextEditingController();
  List<Map<String, dynamic>> userOrders = []; // Mock data for user orders

  @override
  void initState() {
    super.initState();
    
    userOrders = [
      {
        'id': '1',
        'name': 'Coke',
        'price': 1250.0, 
        'imagePath': 'images/can.jpg', 
        'quantity': 2,
      },
      {
        'id': '2',
        'name': 'Chicken Briyani',
        'price': 4500.0, 
        'imagePath': 'images/Briyani.png', 
        'quantity': 1,
      },
    ];
  }

  void _deleteItemInCart(int index) {
    setState(() {
      userOrders.removeAt(index);

      // Show a SnackBar to indicate item deletion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Item deleted successfully',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void _placeOrder(BuildContext context) {
    // Mock logic to simulate placing an order 
    setState(() {
      userOrders.clear(); // Clear the cart after placing the order
      _instructionsController.clear();

      // Show a SnackBar to indicate order placement
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Your order has been placed successfully!',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  int _selectedIndex = 2; // Initial index for CartScreen

  void _onItemTapped(int index) {
    // Handle navigation based on selected index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
        break;
      case 1:
        debugPrint('Search selected');
        break;
      case 2:
        // Do nothing if CartScreen is already selected
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()), // Navigate to ProfileScreen
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userOrders.isEmpty
          ? const Center(
              child: Text('No items in the cart.'),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      'Items in cart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userOrders.length,
                      itemBuilder: (context, index) {
                        var item = userOrders[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CartItem(
                            itemName: item['name'],
                            itemPrice: item['price'],
                            itemImage: item['imagePath'],
                            quantity: item['quantity'],
                            onTap: () {
                              _deleteItemInCart(index);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Other Instructions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _instructionsController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'SSP ${userOrders.fold<double>(
                            0.0,
                            (total, item) =>
                                total + (item['price'] as double) * item['quantity'],
                          ).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Center( // Center the button horizontally
                      child: ElevatedButton(
                        onPressed: () => _placeOrder(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 150.0,
                            vertical: 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0), 
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
