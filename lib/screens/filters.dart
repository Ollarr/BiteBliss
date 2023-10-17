// import 'package:bitebliss/screens/tabs.dart';
// import 'package:bitebliss/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFreeSet = false;
  var _isLactoseFreeSet = false;
  var _isVegetarianFreeSet = false;
  var _isVeganFreeSet = false;

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
            Navigator.of(context).pop({
              Filters.glutenFree: _isGlutenFreeSet,
              Filters.lactoseFree: _isLactoseFreeSet,
              Filters.vegetarian: _isVegetarianFreeSet,
              Filters.vegan: _isVeganFreeSet,
            });
            // N/B: We are returning false here to in the end confirm whether we want to navigate back or not and since we navigating back manually in our case here, hence we are returning false so that we won't in the end be popping twice. In a situation where we are not manually navigating but doing something else like saving data to some database or something, it would be make sense to return true then
            return false;
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
