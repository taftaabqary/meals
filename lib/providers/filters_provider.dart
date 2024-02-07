
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum FilteredMeal {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltersProvider extends StateNotifier<Map<FilteredMeal, bool>> {
  FiltersProvider(): super({
    FilteredMeal.glutenFree: false,
    FilteredMeal.lactoseFree: false,
    FilteredMeal.vegetarian: false,
    FilteredMeal.vegan: false,
  });

  void setFilter(FilteredMeal filter, bool isChecked) {
    state = {
      ...state,
      filter: isChecked
    };
  }

  void setFilters(Map<FilteredMeal, bool> filteredMeals) {
    state = filteredMeals;
  }
}

final filtersProvider = StateNotifierProvider<FiltersProvider, Map<FilteredMeal, bool>>((ref) {
  return FiltersProvider();
} );

final filterMealsProvider = Provider((ref) {
  final mealsDataProvider = ref.watch(mealsProvider);
  final filteredMealsProvider = ref.watch(filtersProvider);

  final availableMeals = mealsDataProvider.where((meal) {
    if(filteredMealsProvider[FilteredMeal.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if(filteredMealsProvider[FilteredMeal.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if(filteredMealsProvider[FilteredMeal.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if(filteredMealsProvider[FilteredMeal.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();

  return availableMeals;
});