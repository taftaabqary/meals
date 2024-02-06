import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class DetailMealScreen extends StatelessWidget {
  const DetailMealScreen({super.key, required this.meal, required this.onToggleFavoriteMeal});

  final Meal meal;
  final void Function(Meal) onToggleFavoriteMeal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavoriteMeal(meal);
              },
              icon: const Icon(Icons.star)
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl)
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary
              ),
            ),
            const SizedBox(height: 14),
            for(final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
            const SizedBox(height: 14),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary
              ),
            ),
            const SizedBox(height: 14),
            for(final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                  textAlign: TextAlign.center,
                ),
              )
        
          ],
        ),
      ),
    );
  }
}