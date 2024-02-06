import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentSelectedIndex = 0;
  final List<Meal> _favoriteMealList = [];
  Map<FilteredMeal, bool> _filteredMealResult = kFilteredMeal;

  void _onSelectedTab(index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  void _onToggleFavoriteMeal(Meal meal) {
    final isExisting = _favoriteMealList.contains(meal);

    if(isExisting) {
      setState(() {
        _favoriteMealList.remove(meal);
        _showMessage('Meal not longer set to favorite');
      });
    } else {
      setState(() {
        _favoriteMealList.add(meal);
        _showMessage('Meal added to favorite');
      });
    }
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
    final availableMeals = dummyMeals.where((meal) {
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

    Widget currentScreen = CategoriesScreen(onToggleFavoriteMeal: _onToggleFavoriteMeal, availableMeals: availableMeals);
    var titleAppBar = 'Categories';

    if(_currentSelectedIndex == 1) {
      currentScreen = MealsScreen(
        listMeals: _favoriteMealList,
        onToggleFavoriteMeal: _onToggleFavoriteMeal,
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