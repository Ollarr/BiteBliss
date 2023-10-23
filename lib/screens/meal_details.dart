import 'package:flutter/material.dart';
import 'package:bitebliss/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitebliss/providers/favourite_meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    // required this.onToggleFavorite
  });

  final Meal meal;
  // final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealProvider);
    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(meal.title), actions: [
        IconButton(
            onPressed: () {
              // onToggleFavorite(meal);
              var isAdded = ref
                  .read(favouriteMealProvider.notifier)
                  .toggleFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(isAdded
                      ? "Meal added from favorite"
                      : "Meal removed from favorite")));
            },
            icon: Icon(isFavourite ? Icons.star : Icons.star_border))
      ]),
      body: SingleChildScrollView(
        child: Column(
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
            Text("Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 16,
            ),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              )
          ],
        ),
      ),
    );
  }
}
