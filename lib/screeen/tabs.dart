import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screeen/categories.dart';
import 'package:meals/screeen/drawer.dart';
import 'package:meals/screeen/filters.dart';
import 'package:meals/screeen/meals.dart';

import '../models/meal.dart';

final Map<FilteredMeal, bool> kFilteredMeal = {
  FilteredMeal.glutenFree: false,
  FilteredMeal.lactoseFree: false,
  FilteredMeal.vegetarian: false,
  FilteredMeal.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentSelectedIndex = 0;
  Map<FilteredMeal, bool> _filteredMealResult = kFilteredMeal;

  void _onSelectedTab(index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  void _onSelectedDrawer(String identifier)  async {
    Navigator.of(context).pop();

    if(identifier == 'filters') {
      final filterResult = await Navigator.of(context).push<
          Map<FilteredMeal, bool>>(
          MaterialPageRoute(builder: (ctx) =>
              FiltersScreen(currentFilteredSwitch: _filteredMealResult,))
      );

      setState(() {
        _filteredMealResult = filterResult ?? kFilteredMeal;
        print(_filteredMealResult);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if(_filteredMealResult[FilteredMeal.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if(_filteredMealResult[FilteredMeal.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if(_filteredMealResult[FilteredMeal.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      if(_filteredMealResult[FilteredMeal.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget currentScreen = CategoriesScreen(availableMeals: availableMeals);
    var titleAppBar = 'Categories';

    if(_currentSelectedIndex == 1) {
      currentScreen = MealsScreen(
        listMeals: ref.watch(favoriteMealsProvider),
      );
      titleAppBar = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      drawer: DrawerScreen(onSelectedDrawer: _onSelectedDrawer),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentSelectedIndex,
          onTap: _onSelectedTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites')
          ]
      ),
    );
  }
}