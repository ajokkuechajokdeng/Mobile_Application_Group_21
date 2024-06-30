import 'package:flutter/material.dart';
import 'package:SpeedyServe/components/add_on.dart';
import 'package:SpeedyServe/components/add_to_cart_button.dart';

class ItemView extends StatefulWidget {
  final String name;
  final String imagePath;
  final double price;
  final String description;

  const ItemView({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
  });

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int _countNumber = 1;

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

  void _addToCart(BuildContext context) {
    // Implement your logic for adding to cart here
    // For this example, we're just showing a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item added to cart!',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SSP ${widget.price * _countNumber}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade700,
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: _decrement,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(
                              side: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                          size: 16.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '$_countNumber',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _increment,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(
                              side: BorderSide(
                                color: Colors.red,
                              ),
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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Ons",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AddOn(),
                        AddOn(),
                        AddOn(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: AddToCart(
                onTap: () => _addToCart(context),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
