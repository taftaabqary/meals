import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key, required this.onSelectedDrawer});

  final void Function(String) onSelectedDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(1), 
                        Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5)
                      ], 
                      begin: Alignment.topLeft, 
                      end: Alignment.bottomRight
                )
              ), 
              child: Row(
                children: [
                  Icon(Icons.fastfood_rounded, size: 48, color: Theme.of(context).colorScheme.onPrimary),
                  const SizedBox(width: 8),
                  Text('Cooking Up!', style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                  ),)
                ],
              ) 
          ),
          
          ListTile(
            leading: Icon(Icons.restaurant, color: Theme.of(context).colorScheme.onBackground),
            title: Text('Meals', style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelectedDrawer('meals');
            },
          ),

          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.onBackground),
            title: Text('Filters', style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelectedDrawer('filters');
            },
          )
        ],
      ),
    );
  }
}