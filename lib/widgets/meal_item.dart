import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screeen/detail_meal.dart';
import 'package:meals/widgets/meal_metadata_item.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectedMeal});

  final Meal meal;
  final Function(Meal) onSelectedMeal;

  String get mealComplexity {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get mealAffordability {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSelectedMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl)
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealMetaData(icon: Icons.timer_outlined, label: '${meal.duration.toString()} min'),
                          const SizedBox(width: 12),
                          MealMetaData(icon: Icons.fastfood, label: mealComplexity),
                          const SizedBox(width: 12),
                          MealMetaData(icon: Icons.attach_money_rounded, label: mealAffordability)
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}