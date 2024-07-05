import 'package:flutter/material.dart';
import 'package:SpeedyServe/screens/onboarding_screens/signin_register_screen.dart';
import 'package:SpeedyServe/screens/app_screens/home_screen.dart';
import 'package:SpeedyServe/screens/app_screens/cart_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkModeEnabled = false; // Example state for dark mode toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile')),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 38.0,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/profile_picture.jpg'),
                        ),
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  Icons.edit,
                                  color: isDarkModeEnabled ? Colors.white : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Placeholder for user display name and email
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDarkModeEnabled ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'user@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkModeEnabled ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Menu Items (Replace with your actual menu items)
              buildMenuItem('Home', Icons.home, Icons.chevron_right),
              buildMenuItem('Payment', Icons.payment, Icons.chevron_right),
              buildMenuItem('Dark Mode', Icons.dark_mode, Icons.toggle_on),
              buildMenuItem('Your Orders', Icons.map, Icons.chevron_right),
              buildMenuItem('Settings', Icons.settings, Icons.chevron_right),
              buildMenuItem('Help Center', Icons.help, Icons.chevron_right),
              const SizedBox(height: 20),
              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  // Example logout logic
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninScreen()),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
        currentIndex: 3, // Set the current index to 'Profile'
        onTap: (index) {
          // Handle navigation based on selected index
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              // Implement navigation to search screen
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
              break;
            case 3:
              // Already on Profile screen
              break;
          }
        },
      ),
    );
  }

  Widget buildMenuItem(String title, IconData leadingIcon, IconData trailingIcon) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leadingIcon,
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Icon(
            trailingIcon == Icons.toggle_on
                ? isDarkModeEnabled
                    ? Icons.toggle_on
                    : Icons.toggle_off
                : trailingIcon,
            color: trailingIcon == Icons.toggle_on
                ? Colors.black
                : isDarkModeEnabled
                    ? Colors.white
                    : Colors.black,
            size: trailingIcon == Icons.toggle_on ? 50 : null,
          ),
        ],
      ),
      onTap: () {
        if (title == 'Dark Mode') {
          setState(() {
            isDarkModeEnabled = !isDarkModeEnabled;
          });
        } else {
          // Handle menu item tap
        }
      },
    );
  }
}
