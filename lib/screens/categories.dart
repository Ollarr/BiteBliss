import 'package:bitebliss/data/data.dart';
import 'package:bitebliss/screens/meals.dart';
import 'package:bitebliss/widgets/category_grid_item.dart';
import 'package:bitebliss/models/category.dart';
import 'package:bitebliss/models/meal.dart';

import 'package:flutter/material.dart';

class CategoriesSCreen extends StatelessWidget {
  const CategoriesSCreen({super.key, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleFavorite: onToggleFavorite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
