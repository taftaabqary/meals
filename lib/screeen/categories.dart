import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screeen/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavoriteMeal,
      required this.availableMeals});

  final void Function(Meal) onToggleFavoriteMeal;
  final List<Meal> availableMeals;

  void _navigateToMealsScreen(BuildContext context, Category category) {
    final formattedMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
          title: category.title,
          listMeals: formattedMeals,
          onToggleFavoriteMeal: onToggleFavoriteMeal);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryItem(
              category: category,
              onSelectedCategory: () {
                _navigateToMealsScreen(context, category);
              })
      ],
    );
  }
}
