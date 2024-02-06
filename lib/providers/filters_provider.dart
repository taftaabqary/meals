
import 'package:flutter_riverpod/flutter_riverpod.dart';

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