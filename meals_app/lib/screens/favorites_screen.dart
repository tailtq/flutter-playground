import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favouriteMeals;

  FavoritesScreen(this._favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Meal meal = _favouriteMeals[index];

        return MealItem(
          id: meal.id,
          imageUrl: meal.imageUrl,
          title: meal.title,
          duration: meal.duration,
          complexityText: meal.complexityText,
          affordabilityText: meal.affordabilityText,
        );
      },
      itemCount: _favouriteMeals.length,
    );
  }
}
