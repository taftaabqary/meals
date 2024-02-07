import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class DetailMealScreen extends ConsumerWidget {
  const DetailMealScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteListProvider = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteListProvider.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final stateToggle = ref.read(favoriteMealsProvider.notifier).onToggleFavoriteMeal(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(stateToggle ? 'Success added to a favorites meal' : 'Remove meal from favorites'))
                );
              },
              icon: Icon((isFavorite) ? Icons.star : Icons.star_border)
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