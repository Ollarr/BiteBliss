import 'package:bitebliss/data/meals.dart';
import 'package:bitebliss/screens/meals.dart';
import 'package:bitebliss/widgets/category_grid_item.dart';
import 'package:bitebliss/models/category.dart';
import 'package:bitebliss/models/meal.dart';

import 'package:flutter/material.dart';

class CategoriesSCreen extends StatefulWidget {
  const CategoriesSCreen(
      {super.key,
      // required this.onToggleFavorite,
      required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesSCreen> createState() => _CategoriesSCreenState();
}

class _CategoriesSCreenState extends State<CategoriesSCreen>
    with SingleTickerProviderStateMixin {
  // final void Function(Meal meal) onToggleFavorite;

  // By using late, you are telling Dart that you promise to initialize
  // _animationController before it's accessed, and it ensures that you
  //won't run into null-related runtime errors. If you try to access
  //_animationController before initializing it, you'll get a runtime error.
  //This is helpful for ensuring that variables are initialized properly,
  //and it can help catch potential bugs during development.
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 2);
    _animationController.forward();
  }

  @override
  void dispose() {
    // This ensures that the animation controller is properly disposed of when the widget
    // is removed from the widget tree, preventing resource leaks.
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // N/B: This is used to filter
    // final filteredMeals = dummyMeals
    //     .where((meal) => meal.categories.contains(category.id))
    //     .toList();

    // N/B: This is used to filter available meals

    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    // Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: filteredMeals,
          // onToggleFavorite: onToggleFavorite
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => (Padding(
              padding:
                  EdgeInsets.only(top: 100 - _animationController.value * 100),
              child: child,
            )),
        child: GridView(
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
        ));
  }
}
