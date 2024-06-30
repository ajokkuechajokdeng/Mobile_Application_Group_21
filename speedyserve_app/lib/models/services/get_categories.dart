import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock category data
    List<Map<String, String>> categories = [
      {"name": "Category 1", "description": "Description of Category 1"},
      {"name": "Category 2", "description": "Description of Category 2"},
      {"name": "Category 3", "description": "Description of Category 3"},
      // Add more mock data as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category['name']!),
            subtitle: Text(category['description']!),
            // Add more UI customization as needed
          );
        },
      ),
    );
  }
}
