// import 'package:bitebliss/data/meals.dart';
import 'package:bitebliss/providers/favourite_meal.dart';
import 'package:bitebliss/providers/meals_provider.dart';
import 'package:bitebliss/screens/categories.dart';
import 'package:bitebliss/screens/filters.dart';
import 'package:bitebliss/screens/meals.dart';
// import 'package:bitebliss/models/meal.dart';
import 'package:bitebliss/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitebliss/providers/filters_provider.dart';

// N/B: This a way of naming global variables i.e adding k before a variable identifier.
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];

  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void showToggleFavoriteMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // void _toggleFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     showToggleFavoriteMessage("Meal removed from favorite");
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     showToggleFavoriteMessage("Meal added to favorite");
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      // final result = await Navigator.of(context).push<Map<Filter, bool>>(
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
            builder: (ctx) => const FiltersScreen(
                // currentFilters: _selectedFilters,
                )),
      );
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
    // else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
// final availableMeals = dummyMeals.where((meal) => {
//   if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree)
// });

    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);

    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesSCreen(
      // onToggleFavorite: _toggleFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealProvider);

      activePage = MealScreen(
        // meals: _favoriteMeals,
        // Here we replace the favorite meals with the functionality from Favourite meals provider
        meals: favouriteMeals,
        // onToggleFavorite: _toggleFavoriteStatus,
      );
      activePageTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ]),
    );
  }
}
