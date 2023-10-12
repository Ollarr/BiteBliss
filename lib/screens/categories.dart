import 'package:bitebliss/data/data.dart';
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
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        // N/B: The CategoryGridItems can be rendered using either map or for in loop
        // children: availableCategories.map((category) => CategoryGridItem(category: category)).toList(),

        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category)
        ],
      ),
    );
  }
}
