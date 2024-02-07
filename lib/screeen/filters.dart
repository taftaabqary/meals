import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchFilterSet = ref.watch(filtersProvider);
    return Scaffold(
          appBar: AppBar(
            title: const Text('Your Filters'),
          ),

          body: Column(
            children: [
              SwitchListTile(
                value: switchFilterSet[FilteredMeal.glutenFree]!,
                onChanged: (isChecked) {
                  ref.read(filtersProvider.notifier).setFilter(FilteredMeal.glutenFree, isChecked);
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
                  value: switchFilterSet[FilteredMeal.lactoseFree]!,
                  onChanged: (isChecked) {
                    ref.read(filtersProvider.notifier).setFilter(FilteredMeal.lactoseFree, isChecked);
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
                  value: switchFilterSet[FilteredMeal.vegetarian]!,
                  onChanged: (isChecked) {
                    ref.read(filtersProvider.notifier).setFilter(FilteredMeal.vegetarian, isChecked);
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
                  value: switchFilterSet[FilteredMeal.vegan]!,
                  onChanged: (isChecked) {
                    ref.read(filtersProvider.notifier).setFilter(FilteredMeal.vegan, isChecked);
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
    );
  }
}