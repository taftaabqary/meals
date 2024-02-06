import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../models/meal.dart';
import 'detail_meal.dart';

class MealsScreen extends StatelessWidget {

  const MealsScreen({super.key, this.title, required this.listMeals, required this.onToggleFavoriteMeal});

  final String? title;
  final List<Meal> listMeals;
  final void Function(Meal) onToggleFavoriteMeal;

  void goToDetailMealScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DetailMealScreen(
      meal: meal,
      onToggleFavoriteMeal: onToggleFavoriteMeal,
    )
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Whoops, nothing here..',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 20,),
            Text(
              'Try to selecting different category!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        )
    );

    if(listMeals.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: listMeals.length,
          itemBuilder: (ctx, index) => MealItem(meal: listMeals[index], onSelectedMeal: (meal) {
            goToDetailMealScreen(context, meal);
          })
      );
    }

    if(title == null) {
      return mainContent;
    }

    return Scaffold(
        appBar: AppBar(
        title: Text(title!),
      ),
        body: mainContent
    );
  }

}