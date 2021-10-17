import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';
  final List<Meal> _meals;

  CategoryMealsScreen(this._meals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryId;
  late String categoryTitle;
  late List<Meal> categoryMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryId = routeArgs['categoryId']!;
      categoryTitle = routeArgs['categoryTitle']!;
      categoryMeals = widget._meals.where((element) {
        return element.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
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
