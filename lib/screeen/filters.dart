import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    final currentFilteredSwitch = ref.read(filtersProvider);
    _glutenFreeFilterSet = currentFilteredSwitch[FilteredMeal.glutenFree]!;
    _lactoseFreeFilterSet = currentFilteredSwitch[FilteredMeal.lactoseFree]!;
    _vegetarianFilterSet = currentFilteredSwitch[FilteredMeal.vegetarian]!;
    _veganFilterSet = currentFilteredSwitch[FilteredMeal.vegan]!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool isPop) {
        if(isPop) {
          ref.read(filtersProvider.notifier).setFilters({
            FilteredMeal.glutenFree: _glutenFreeFilterSet,
            FilteredMeal.lactoseFree: _lactoseFreeFilterSet,
            FilteredMeal.vegetarian: _vegetarianFilterSet,
            FilteredMeal.vegan: _veganFilterSet,
          });
        } else {
          return ;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Your Filters'),
          ),

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