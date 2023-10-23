// import 'package:bitebliss/screens/tabs.dart';
// import 'package:bitebliss/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bitebliss/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters
  });

  // final Map<Filter, bool> currentFilters;
  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _isGlutenFreeSet = false;
  var _isLactoseFreeSet = false;
  var _isVegetarianFreeSet = false;
  var _isVeganFreeSet = false;

  @override
// This is done to override the filter variables as the state changes
//when users switch the filters on or off and save the current filter state
//This is not implementable at initialization point, it can only be used inside a method
//like we are doing in the initState method.

  void initState() {
    super.initState();
    final currentActiveFilter = ref.read(filtersProvider);

    _isGlutenFreeSet = currentActiveFilter[Filter.glutenFree]!;
    _isLactoseFreeSet = currentActiveFilter[Filter.lactoseFree]!;
    _isVegetarianFreeSet = currentActiveFilter[Filter.vegetarian]!;
    _isVeganFreeSet = currentActiveFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Filters"),
        ),
        // drawer: MainDrawer(
        //   onSelectScreen: (identifier) {
        //     Navigator.of(context).pop();
        //     if (identifier == 'meals') {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(builder: (ctx) => const TabsScreen()),
        //       );
        //     }
        //   },
        // ),
        body: WillPopScope(
          onWillPop: () async {
            ref.read(filtersProvider.notifier).setFilters({
              Filter.glutenFree: _isGlutenFreeSet,
              Filter.lactoseFree: _isLactoseFreeSet,
              Filter.vegetarian: _isVegetarianFreeSet,
              Filter.vegan: _isVeganFreeSet,
            });
            // Navigator.of(context).pop({
            //   Filter.glutenFree: _isGlutenFreeSet,
            //   Filter.lactoseFree: _isLactoseFreeSet,
            //   Filter.vegetarian: _isVegetarianFreeSet,
            //   Filter.vegan: _isVeganFreeSet,
            // });

            // N/B: We are returning false here to in the end confirm whether we want to navigate back or not and since we navigating back manually in our case here, hence we are returning false so that we won't in the end be popping twice. In a situation where we are not manually navigating but doing something else like saving data to some database or something, it would be make sense to return true then
            // return false;
            return true;
          },
          child: Column(children: [
            SwitchListTile(
              value: _isGlutenFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _isGlutenFreeSet = isChecked;
                });
              },
              title: Text(
                "Gluten-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only includes gluten-free meals.",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 24),
            ),
            SwitchListTile(
              value: _isLactoseFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _isLactoseFreeSet = isChecked;
                });
              },
              title: Text(
                "Lactose-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only includes lactose-free meals.",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 24),
            ),
            SwitchListTile(
              value: _isVegetarianFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _isVegetarianFreeSet = isChecked;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only includes vegetarian meals.",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 24),
            ),
            SwitchListTile(
              value: _isVeganFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _isVeganFreeSet = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only includes vegan meals.",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 32, right: 24),
            ),
          ]),
        ));
  }
}
