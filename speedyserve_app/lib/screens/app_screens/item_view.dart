import 'package:SpeedyServe/models/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/add_on.dart';
import 'package:SpeedyServe/components/add_to_cart_button.dart';
import 'package:uuid/uuid.dart';

class ItemView extends StatefulWidget {
  final String name;
  final String imagePath;
  final double price;
  final String description;

  const ItemView({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  FirebaseAuthServices _authservices = FirebaseAuthServices();
  User? _currentUser;
  int _countNumber = 1;

  @override
  void initState() {
    super.initState();
    getCurrentUser(); // Call method to get current user when the screen initializes
  }

  Future<void> getCurrentUser() async {
    User? user = await _authservices.getCurrentUser(); // Get current user
    setState(() {
      _currentUser = user; // Update state with current user
    });
  }

  void _increment() {
    setState(() {
      _countNumber++;
    });
  }

  void _decrement() {
    setState(() {
      if (_countNumber > 1) {
        _countNumber--;
      }
    });
  }

  // Function to add the item to the cart
  void addUserItemToCard(BuildContext context) async {
    try {
      // A reference to the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Saves data to the Firestore
      final Map<String, dynamic> orderData = {
        'id': const Uuid().v4(),
        'user': _currentUser!.email,
        'name': widget.name,
        'imagePath': widget.imagePath,
        'price': widget.price * _countNumber,
        'quantity': _countNumber,
      };

      // Adds the order to a collection named "Orders"
      await firestore.collection('Orders').add(orderData);

      // Delay showing the SnackBar to avoid interference with the "Close" button
      await Future.delayed(const Duration(milliseconds: 500));

      // Show a success message using a SnackBar
      // ignore: use_build_context_synchronously
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

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (error) {
      // Handle any errors that occur during the process
      debugPrint("Error adding order to Firestore: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16.0,
                                  ),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              ' ${widget.price * _countNumber}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: _decrement,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      const CircleBorder(
                                        side: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                    size: 16.0,
                                  ),
                                ),
                                Text(
                                  '$_countNumber',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: _increment,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      const CircleBorder(
                                        side: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                    size: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Add Ons",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              AddOn(),
                              AddOn(),
                              AddOn(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        AddToCart(
                          onTap: () => addUserItemToCard(context),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
