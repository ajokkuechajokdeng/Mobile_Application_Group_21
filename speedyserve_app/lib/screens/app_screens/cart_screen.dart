import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/cart_item.dart';


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
    // Mock data initialization (replace with your own logic if needed)
    userOrders = [
      {
        'id': '1',
        'name': 'Item 1',
        'price': 20.0, // Ensure price is a double
        'imagePath': 'https://via.placeholder.com/150', // Sample image URL
        'quantity': 2,
      },
      {
        'id': '2',
        'name': 'Item 2',
        'price': 30.0, // Ensure price is a double
        'imagePath': 'https://via.placeholder.com/150', // Sample image URL
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
    // Mock logic to simulate placing an order (replace with your own logic)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
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
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _placeOrder(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
