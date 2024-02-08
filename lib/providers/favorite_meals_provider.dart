
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteProvider extends StateNotifier<List<Meal>> {
  FavoriteProvider() : super([]);

  bool onToggleFavoriteMeal(Meal meal) {
    final existingMeal = state.contains(meal);

    if(existingMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}


final favoriteMealsProvider = StateNotifierProvider<FavoriteProvider, List<Meal>>((ref) {
  return FavoriteProvider();
});