import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routeName = '/category-meals';

  const CategoryMealsScreen();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['categoryId'];
    final categoryTitle = routeArgs['categoryTitle'];
    final categoryMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Meal meal = categoryMeals[index];

            return MealItem(
              id: meal.id,
              imageUrl: meal.imageUrl,
              title: meal.title,
              duration: meal.duration,
              complexityText: meal.complexityText,
              affordabilityText: meal.affordabilityText,
            );
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
