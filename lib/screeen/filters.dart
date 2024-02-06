import 'package:flutter/material.dart';

enum FilteredMeal {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilteredSwitch});

  final Map<FilteredMeal, bool> currentFilteredSwitch;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    _glutenFreeFilterSet = widget.currentFilteredSwitch[FilteredMeal.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilteredSwitch[FilteredMeal.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilteredSwitch[FilteredMeal.vegetarian]!;
    _veganFilterSet = widget.currentFilteredSwitch[FilteredMeal.vegan]!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) {
        if(isPop) {
          return;
        } else {
          Navigator.of(context).pop(
              {
                FilteredMeal.glutenFree: _glutenFreeFilterSet,
                FilteredMeal.lactoseFree: _lactoseFreeFilterSet,
                FilteredMeal.vegetarian: _vegetarianFilterSet,
                FilteredMeal.vegan: _veganFilterSet,
              });
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Your Filters'),
          ),

          // drawer: DrawerScreen(
          //     onSelectedDrawer: (identifier) {
          //       Navigator.of(context).pop();
          //       if(identifier == 'meals') {
          //         setState(() {
          //           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
          //         });
          //       }
          //     }
          // ),

          body: Column(
            children: [
              SwitchListTile(
                value: _glutenFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeFilterSet = isChecked;
                  });
                },
                title: Text('Gluten-Free', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text('Filtered only showing gluten-free meals.', style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22)
              ),

              SwitchListTile(
                value: _lactoseFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeFilterSet = isChecked;
                  });
                },
                title: Text('Lactose-Free', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text('Filtered only showing lactose-free meals.', style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22)
              ),

              SwitchListTile(
                value: _vegetarianFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vegetarianFilterSet = isChecked;
                  });
                },
                title: Text('Vegetarian', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text('Filtered only showing vegetarian meals.', style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22)
              ),

              SwitchListTile(
                value: _veganFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _veganFilterSet = isChecked;
                  });
                },
                title: Text('Vegan', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text('Filtered only showing vegan meals.', style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22)
              ),
            ],
          ),
      ),
    );
  }
}