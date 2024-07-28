import 'package:SpeedyServe/models/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/cart_item.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _instructionsController = TextEditingController();
  FirebaseAuthServices _authservices = FirebaseAuthServices();
  User? _currentUser;
  Stream<QuerySnapshot> userorders = Stream.empty();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = await _authservices.getCurrentUser();
    setState(() {
      _currentUser = user;
      userorders = FirebaseFirestore.instance
          .collection('Orders')
          .where('user', isEqualTo: _currentUser?.email ?? '')
          .snapshots();
    });
  }

  void _deleteItemInCart(String id) async {
    await FirebaseFirestore.instance.collection('Orders').doc(id).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Item deleted successfully',
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.red,
    ));
  }

  void _placeOrder(BuildContext context) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot ordersSnapshot = await firestore
          .collection('Orders')
          .where('user', isEqualTo: _currentUser!.email)
          .get();

      for (QueryDocumentSnapshot order in ordersSnapshot.docs) {
        Map<String, dynamic> orderData = order.data() as Map<String, dynamic>;

        await firestore.collection('ConfirmedOrders').add({
          'id': Uuid().v4(),
          'order': orderData,
          'user': _currentUser!.email,
          'instructions': _instructionsController.text,
          'time': Timestamp.now(),
        });
        await firestore.collection('Orders').doc(order.id).delete();
      }

      setState(() {
        _instructionsController.clear();
      });

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

      debugPrint("Orders moved to ConfirmedOrders successfully!");
    } catch (error) {
      debugPrint("Error placing order: $error");
    }
  }

  double calculateTotalPrice(List<QueryDocumentSnapshot> docs) {
    double total = 0.0;
    for (var doc in docs) {
      total += (doc['price'] as num) * (doc['quantity'] as num);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser != null
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'Items in cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40.0),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: userorders,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No data found'));
                        }

                        final data = snapshot.requireData;
                        double totalPrice = calculateTotalPrice(data.docs);

                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.docs.length,
                                itemBuilder: (context, index) {
                                  var doc = data.docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CartItem(
                                          itemName: doc['name'],
                                          itemPrice: doc['price'],
                                          itemImage: doc['imagePath'],
                                          quantity: doc['quantity'],
                                          onTap: () {
                                            _deleteItemInCart(doc.id);
                                          }),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Other Instructions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              controller: _instructionsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'SSP ${totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () => _placeOrder(context),
                                child: const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 9.0),
                                    child: Text(
                                      'Place Order',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
