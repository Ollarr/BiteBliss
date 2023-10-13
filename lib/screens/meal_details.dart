import 'package:flutter/material.dart';
import 'package:bitebliss/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(meal.title)),
      body: Column(
        children: [
          Image.network(
            meal.imageUrl,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
          const SizedBox(
            height: 12,
          ),
          Text("ingredients",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 16,
          ),
          for (final ingredient in meal.ingredients)
            Text(ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground))
        ],
      ),
    );
  }
}
