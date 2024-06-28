import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:SpeedyServe/screens/app_screens/cart_screen.dart';
import 'package:SpeedyServe/screens/app_screens/home_screen.dart';
import 'package:SpeedyServe/screens/app_screens/profile_screen.dart';

class HomeEntry extends StatefulWidget {
  const HomeEntry({Key? key}) : super(key: key);

  @override
  _HomeEntryState createState() => _HomeEntryState();
}

class _HomeEntryState extends State<HomeEntry> {
  final List<Widget> _widgetOptions = <Widget>[
     HomeScreen(),
    Container(), // Placeholder for SearchScreen, replace with actual implementation
    const CartScreen(),
    const ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Colors.red.shade500,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.transparent,
              color: Colors.grey[600]!,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search', // Change to actual label
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Cart',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
