import 'package:bitebliss/data/category_data.dart';
import 'package:bitebliss/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesSCreen extends StatelessWidget {
  const CategoriesSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Category"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          // N/B: The CategoryGridItems can be rendered using either map or for in loop
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()

          for (final category in availableCategories)
            CategoryGridItem(category: category)
        ],
      ),
    );
  }
}
